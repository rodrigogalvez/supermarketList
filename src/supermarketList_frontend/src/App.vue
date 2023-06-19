<template>
    <details>
        <summary role="button" class="secondary">Saludar</summary>
        <form v-on:submit.prevent>
            <div class="grid">
                <label>Nombre
                    <input type="text" v-model="name" placeholder="Nombre">
                </label>
            </div>
            <button type="submit" v-on:click="callGreet()">Submit</button>
            <blockquote>
                {{ greeting }}
                <footer>
                    <cite>Resultado</cite>
                </footer>
            </blockquote>
        </form>
    </details>
</template>

<script>

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
export default {
    data: () => {
        return {
            name: "",
            greeting: ""
        };
    },
    methods: {
        async callGreet() {
            const result = await supermarketList_backend.greet(this.name);
            this.greeting = result;
        }
    }
}
</script>