class GetCurrentMonthProgress
  def initialize(params)
    @user = params.fetch(:user)
  end

  def call
    current_month_progress = {}
    dates_in_current_month = datetime_sequence(Date.today.beginning_of_month, Date.today.end_of_month, 1.day)

    dates_in_current_month.each do |date|
      index_date = date.to_date.strftime("%d/%m/%Y").to_s
      date_exists = Post.where(user: @user).where("DATE(created_at) = ?", date.to_date).exists?

      current_month_progress[index_date] = date_exists
    end

    current_month_progress
  end

  private

  def datetime_sequence(start, stop, step)
    dates = [start]
    while dates.last < (stop - step)
      dates << (dates.last + step)
    end
    return dates
  end
end
