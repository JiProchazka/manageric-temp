class GetStateButtonsService

  def get_values state
    values = []
    ProjectItem.all_states.each do |key, value|
      values << { title: key.labelize, selected: key == state, css_class: get_css_class(key, state), value: key.to_s, order: value }
    end
    values.sort!{ |a, b| a[:order] <=> b[:order] }
  end

  private

  def disabled_combinations
    @disabled_combinations ||= {}
    @disabled_combinations[:not_started] = [] << :stopped
    @disabled_combinations[:stopped] = [] << :not_started
    @disabled_combinations[:in_progress] = [] << :not_started
    @disabled_combinations[:done] = [] << :not_started << :stopped
    @disabled_combinations[:client_accepted] = [] << :not_started << :stopped << :done
    @disabled_combinations
  end

  def get_css_class key, state
    if key == state
      return " active"
    elsif !disabled_combinations[state].nil? && disabled_combinations[state].include?(key)
      return " disabled"
    else
      return ""
    end
  end

end
