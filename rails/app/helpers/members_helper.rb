module MembersHelper
  def member_path(member, params = {})
    if member.senator?
      # TODO Seems odd to me the mpc=Senate would expect mpc=Tasmania
      r = "mp.php?mpn=#{member.url_name}&mpc=Senate&house=#{member.australian_house}"
    else
      r = "mp.php?mpn=#{member.url_name}&mpc=#{member.electorate}&house=#{member.australian_house}"
    end
    r += "&parliament=#{params[:parliament]}" if params[:parliament]
    r += "&display=#{params[:display]}" if params[:display]
    r += "##{params[:anchor]}" if params[:anchor]
    r
  end

  def members_path(params)
    p = ""
    p += "&parliament=#{params[:parliament]}" if params[:parliament]
    p += "&house=#{params[:house]}" if params[:house] && params[:house] != "representatives"
    p += "&sort=#{params[:sort]}"
    r = "/mps.php"
    r += "?" + p[1..-1] if p != ""
    r
  end

  def sort_link(sort, sort_name, name, current_sort)
    if current_sort == sort
      content_tag(:b, name)
    else
      link_to name, members_path(params.merge(sort: sort)), alt: "Sort by #{sort_name}"
    end
  end

  def display_link2(member, members, electorate, display, name, title, current_display)
    if current_display == display
      content_tag(:li, name, class: "on")
    else
      content_tag(:li, class: "off") do
        path = if members && members.count > 1
          electorate_path2(electorate, display: display)
        else
          member_path(member, display: display)
        end
        link_to name, path, title: title, class: "off"
      end
    end
  end
end