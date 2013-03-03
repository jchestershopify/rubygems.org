class Api::V1::VersionsController < Api::BaseController
  respond_to :json, :xml, :yaml
  before_filter :find_rubygem

  def show
    if @rubygem.public_versions.count.nonzero?

      if stale?(@rubygem)
        respond_with(@rubygem.public_versions, :yamlish => true)
      end
    else
      render :text => "This rubygem could not be found.", :status => 404
    end
  end

  def reverse_dependencies
    respond_with(Version.reverse_dependencies(params[:id]), :yamlish => true)
  end
end
