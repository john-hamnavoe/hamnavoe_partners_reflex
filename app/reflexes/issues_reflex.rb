# frozen_string_literal: true

class IssuesReflex < ApplicationReflex
  def new
    @issue = Issue.new
    @issue.owner = current_user
  end

  def edit
    @issue = repo.load(element.dataset[:id])
  end

  def change_archive_filter
    archive_status = session[:issue_include_archived] || false
    session[:issue_include_archived] = !archive_status
  end

  private

  # remember that variables carry through to controller so if make a variable then name appropriately to not mess with the controller
  def repo
    IssueRepository.new(current_user)
  end
end
