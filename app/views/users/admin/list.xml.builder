xml.rows do
  xml.page(@page)
  xml.total(@nbr_pages)
  xml.records(@users.size)
  @users.each do |user|
    xml.row({:id => user.id}) do
      xml.cell(user.login)
      xml.cell(user.role_strings.join(","))
      xml.cell(user.login_count)
      xml.cell(user.failed_login_count)
      xml.cell(user.current_login_at)
      xml.cell(user.last_login_at)
      xml.cell(user.last_login_ip)
      xml.cell(user.created_at)
      xml.cell(user.updated_at)
      xml.cell(user.password)
      xml.cell(user.password_confirmation)
    end
  end
end
