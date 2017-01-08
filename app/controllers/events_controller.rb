class EventsController < ApplicationController

  def create
    begin
      event_addr = Resolv.getname(request.remote_addr)
      addr_parts = event_addr.split('.')
      domain = !addr_parts[-2].nil? ? addr_parts[-2] + '.' +addr_parts[-1] : addr_parts[-1]
      subdomain = addr_parts[-3]

      Event.create(string: params[:string], event_addr: event_addr, domain: domain, subdomain: subdomain)
      status = 200
    rescue
      status = 500
    end

    render :nothing => true, :status => status
  end

  def show
    where_hash = {domain: params[:org]}

    if !params[:host].nil?
      where_hash[:subdomain] = params[:host]
    end

    row_limit = params[:limit]

    results = Event.select(:id, :string, :event_addr, :domain, :subdomain, :created_at).where(where_hash).order(created_at: :desc).limit(row_limit)

    render json: results
  end
end
