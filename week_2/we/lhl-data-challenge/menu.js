const toggleSub = function (element) {
  element.classList.contains("show")
    ? element.classList.remove("show")
    : element.classList.add("show"),
    element.parentElement.classList.add("parentShow");
};

document.onclick = function hideMenu(event) {
  const subButton = event.target.classList.contains("subnavButton");
  const subNavs = document.querySelectorAll("[class^=sub_Nav-]");
  const navSelect = document.getElementsByClassName("show");

  if (!subButton) {
    subNavs.forEach(function (element) {
      element === subNavs
        ? toggleSub(element)
        : element.classList.remove("show"),
        element.parentElement.classList.remove("parentShow");
    });
  } else {
  }
};

function dropDownHandler(event) {
  event.preventDefault();
  const subnav = event.currentTarget.nextElementSibling;

  if (
    Array.from(subnav.classList).some(function (className) {
      return className.includes("sub_Nav");
    })
  ) {
    document.querySelectorAll("[class^=sub_Nav-]").forEach(function (element) {
      element === subnav
        ? toggleSub(element)
        : element.classList.remove("show");
    });
  } else {
    toggleSub(subnav);
  }
}

// Build in routing active state
window.onload = function (element) {
  const menuId = document.getElementById("mainNav");

  const currentRoute = window.location;

  switch (true) {
    case currentRoute.href.includes("about"):
      document.getElementById("nav_about").classList.add("active");
      break;
    case currentRoute.href.includes("practice"):
      document.getElementById("nav_practice").classList.add("active");
      break;
    case currentRoute.href.includes("challenges"):
      document.getElementById("nav_challenges").classList.add("active");
      break;
    case currentRoute.href.includes("teams"):
      document.getElementById("nav_teams").classList.add("active");
      break;
    case currentRoute.href.includes("prizing"):
      document.getElementById("nav_prizing").classList.add("active");
      break;
    case currentRoute.href.includes("account"):
      document.getElementById("nav_account").classList.add("active");
      break;
    case currentRoute.href.includes("admin"):
      document.getElementById("nav_admin").classList.add("active");
      break;
    case currentRoute.href.includes("register"):
      document.getElementById("nav_register").classList.add("active");
      break;
    case currentRoute.href.includes("sign-in"):
      document.getElementById("nav_signin").classList.add("active");
      break;
    default:
      menuId.children[0].classList.add("active");
  }
};
