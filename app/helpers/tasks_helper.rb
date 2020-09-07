# frozen_string_literal: true

module TasksHelper
  def badge_status(task)
    case task.status.to_sym
    when :waiting
      'badge-secondary'
    when :working
      'badge-primary'
    when :pending
      'badge-warning'
    when :discontinued
      'badge-secondary'
    when :approval_waiting
      'badge-info'
    when :completed
      'badge-success'
    when :approval_rescission
      'badge-danger'
    end
  end
end
