class ReportsController < ApplicationController
  def index
    @subscriptions = Subscription.all.includes [:plan, :customer]
    
    days = (0..30).map { |e| e.days.ago }.reverse
    
    @mrr = []; @new_users = []; @users = []; @cancellations = []; @dates = []
    
    active_users = 0 # Need to fix this to bring active users who were active when the report begins
    
    days.each do |day|
      revenue = 0
      revenue = @subscriptions
        .select { |e| e.cancelled_at ? e.started_at < day && e.cancelled_at > day : e.started_at < day }
        .map { |e| e.monthly_revenue.round 2  }
        .sum

      cancellation = @subscriptions.select {|e| e.cancelled_at&.to_date == day.to_date }.size
      new_user = @subscriptions.select {|e| e.started_at.to_date == day.to_date }.size
      active_users += new_user - cancellation

      @users.push active_users
      @new_users.push new_user
      @cancellations.push cancellation
      @mrr.push revenue
      @dates.push day.strftime '%b %d'
    end
  end
end
