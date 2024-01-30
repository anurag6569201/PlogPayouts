

//   text revealing js
gsap.registerPlugin(ScrollTrigger);
gsap.utils.toArray(".revealUp").forEach(function (elem) {
  ScrollTrigger.create({
    trigger: elem,
    start: "top 70%",
    end: "bottom 20%",
    markers: false,
    onEnter: function () {
      gsap.fromTo(
        elem,
        { y: 100, autoAlpha: 0 },
        {
          duration: 1.25,
          y: 0,
          autoAlpha: 1,
          ease: "back",
          overwrite: "auto"
        }
      );
    },
    onLeave: function () {
      gsap.fromTo(elem, { autoAlpha: 1 }, { autoAlpha: 0, overwrite: "auto" });
    },
    onEnterBack: function () {
      gsap.fromTo(
        elem,
        { y: -100, autoAlpha: 0 },
        {
          duration: 1.25,
          y: 0,
          autoAlpha: 1,
          ease: "back",
          overwrite: "auto"
        }
      );
    },
    onLeaveBack: function () {
      gsap.fromTo(elem, { autoAlpha: 1 }, { autoAlpha: 0, overwrite: "auto" });
    }
  });
});


// profile section
let show_profile = document.querySelector(".navbar-brand img");
let profile = document.querySelector(".profile");

show_profile.addEventListener("click", () => {
  let profile = document.querySelector(".profile");
  if (profile.style.display == "block") {
    profile.style.display = "none";
  } else {
    profile.style.display = "block";
  };
})
document.addEventListener("click", (event) => {
  if (!profile.contains(event.target) && event.target !== show_profile) {
    profile.style.display = "none";
  }
});




