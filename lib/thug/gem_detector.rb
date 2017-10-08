module Thug
	class GemDetector

		def initialize
			cwd = Dir.getwd
			@gemfile_path = cwd + "/Gemfile"
		end

		def has_gem?
			File.file?(@gemfile_path)
		end

		# update the .lock file without installing gems
		def update_lock
			puts "updating gemfile.lock"
			`bundle lock`
			puts "updated"
		end

		def list_gems
			self.update_lock

			@gemfile_path = File.expand_path(@gemfile_path)

			lockfile_path = "#{@gemfile_path}.lock"
			lockfile = Bundler::LockfileParser.new(Bundler.read_file(lockfile_path))

			lockfile.specs.map(&:name)
		end
		
	end
end
