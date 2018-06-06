class ReportsController < ApplicationController
  def index
    @subscriptions = Subscription.all.includes [:plan, :customer]
    
    days = (0..30).map { |e| e.days.ago }.reverse
    
    @mrr = []; @new_customers = []; @customers = []; @cancellations = []; @dates = []
    
    days.each do |day|
      active_subscriptions = @subscriptions
        .select { |e| e.cancelled_at ? e.started_at < day && e.cancelled_at > day : e.started_at < day }
      
      revenue = active_subscriptions
        .map { |e| e.monthly_revenue.round 2  }
        .sum

      cancellation = @subscriptions.select {|e| e.cancelled_at&.to_date == day.to_date }.uniq {|e| e.customer_id }.size
      new_customer = @subscriptions.select {|e| e.started_at.to_date == day.to_date }.size
      active_customers = active_subscriptions.uniq {|e| e.customer_id }.size


      @customers.push active_customers
      @new_customers.push new_customer
      @cancellations.push cancellation
      @mrr.push revenue
      @dates.push day.strftime '%b %d'
    end
  end
end
