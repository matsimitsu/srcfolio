class ContributorsController < ApplicationController
  def index
    @contributors = Contributor.all
  end

  def show
    unless @contributor = Contributor.find_by_login(params[:id])
      return render :not_found, :status => 404
    end
    @contributions = @contributor.contributions.map{|c| c.merge({'project' => Project.find(c['project'])})}
  end
end
