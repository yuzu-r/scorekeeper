class Session
	attr_reader :start_time, :stop_time
	attr_reader :current_score, :first_score
	attr_reader :record

	def initialize
		@record = []
	end

	def start_session
		@start_time = Time.now
		@stop_time = nil
	end

	def stop_session
		@stop_time = Time.now
		self.reset
	end

	def update_score(score)
		if @record.last
			difference = (score.to_i - @record.last).to_s
		else
			difference = "n/a"
		end
		@record.push score.to_i
		"**Latest SR:** #{score} **Difference:** #{difference}"
	end

	def overall_score
		if @record.empty?
			"n/a"
		else
			(@record.last - @record.first).to_s
		end
	end

	def duration
		if !@start_time
			"no session active"
		else
			stop_time = Time.now
			formatted_duration((stop_time - @start_time).ceil)
		end
	end

	def stats
		<<~HEREDOC
      Session duration: #{self.duration}
      Record: #{self.get_record}
      Net gain/loss: #{self.overall_score}
    HEREDOC
	end

	def get_record
		if @record.empty?
			"no scores logged!"
		else
			differential = @record.each_cons(2).map{|a, b| b - a}
			wins = differential.select{|d| d > 0}.count
			losses = differential.select{|d| d < 0}.count
			ties = differential.select{|d| d == 0}.count
			"#{pluralize(wins,"win")}, #{pluralize(losses, "loss", "losses")}, #{pluralize(ties, "tie")}"
		end
	end

	def reset
		@start_time = nil
		@stop_time = nil
		@current_score = nil
		@first_score = nil
		@record = []
	end

	private
		def pluralize(n, singular, plural = nil)
			# https://stackoverflow.com/questions/2446156/is-there-a-pluralize-function-in-ruby-not-rails
			if n == 1
				"#{n} #{singular}"
			elsif plural
				"#{n} #{plural}"
			else
				"#{n} #{singular}s"
			end
		end

	  def formatted_duration(total_seconds)
	    hours = total_seconds / (60 * 60)
	    minutes = (total_seconds / 60) % 60
	    seconds = total_seconds % 60

	    "#{ hours } h #{ minutes } m #{ seconds } s"
  	end
end