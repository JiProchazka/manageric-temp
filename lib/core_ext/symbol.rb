class Symbol
  def labelize
    self.to_s.humanize.split.map(&:capitalize).join(' ')
  end
end
