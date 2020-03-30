# frozen_string_literal: true

class DocsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.all.order("created_at DESC")
  end

  def show
    @doc = Doc.find(params[:id])
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params)
    if @doc.save
      redirect_to @doc
    else
      render action: 'new'
    end
  end

  def edit; end

  def update
    @doc = Doc.find(params[:id])
    if @doc.update(doc_params)
      redirect_to @doc
    else
      render action: 'edit'
    end
  end

  def destroy
    @doc = Doc.find(params[:id])
    if @doc.delete
      redirect_to docs_path
      flash[:notice] = 'Dosc was successfuly  deleted'
    else
      flash[:notice] = 'Something is wrong, please try again'
    end
  end

  private

  def find_params
    @doc = Doc.find(params[:id])
  end

  def doc_params
    params.require(:doc).permit(:title, :content)
  end
end
