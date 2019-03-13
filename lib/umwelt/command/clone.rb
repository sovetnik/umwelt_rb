# frozen_string_literal: true

module Umwelt::Command
  class Clone < Base
    expose :written_paths

    def initialize(path: '.umwelt')
      @path = path
      @written_paths = {}
    end

    def call(user_project: '/')
      user_name, project_name = user_project.split('/')

      project = get_project(
        project_name: project_name, user_name: user_name
      )
      store_project!(project)

      history = get_history(project.project_id)
      store_history!(history)
      get_episodes(history)
    end

    private

    def get_episodes(history)
      history.phases.map do |phase|
        next if episode_exist? phase.id

        episode = get_episode(phase.id)
        store_episode!(phase.id, episode)
      end
    end

    def episode_exist?(phase_id)
      Umwelt::Episode::File::Restore
        .new(path: @path)
        .call(phase_id)
        .success?
    end

    def store_episode!(id, episode)
      @written_paths.merge! prove(
        Umwelt::Episode::File::Store
        .new(path: @path)
        .call(id, episode)
      ).written_paths
    end

    def get_episode(phase_id)
      prove(Umwelt::Episode::Get.new.call(phase_id)).episode
    end

    def store_history!(history)
      @written_paths.merge! prove(
        Umwelt::History::File::Store.new(path: @path).call(history)
      ).written_paths
    end

    def get_history(project_id)
      prove(Umwelt::History::Get.new.call(project_id)).history
    end

    def store_project!(project)
      @written_paths.merge! prove(
        Umwelt::Project::File::Store.new(path: @path).call(project)
      ).written_paths
    end

    def get_project(user_project)
      prove(Umwelt::Project::Get.new.call(user_project)).project
    end
  end
end
