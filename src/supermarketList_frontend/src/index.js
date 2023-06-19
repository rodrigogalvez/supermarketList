import { supermarketList_backend } from "../../declarations/supermarketList_backend";

// document.querySelector("form").addEventListener("submit", async (e) => {
//   e.preventDefault();
//   const button = e.target.querySelector("button");

//   const name = document.getElementById("name").value.toString();

//   button.setAttribute("disabled", true);

//   // Interact with foo actor, calling the greet method
//   const greeting = await supermarketList_backend.greet(name);
//   const statusList =await supermarketList_backend.enumerateStatus();
//   console.log(statusList);

//   button.removeAttribute("disabled");

//   document.getElementById("greeting").innerText = greeting;

//   return false;
// });

const { createApp, ref } = Vue;
createApp({
  setup() {

  }
}).mount("#app");