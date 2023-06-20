<template>
    <div v-if="data.mode == 0">
        <div class="grid">
            <button v-on:click="refresh" v-bind:disabled="data.busy">Actualizar</button>
            <button v-on:click="appendMode" class="secondary">Agregar</button>
        </div>
        <section v-for="task in data.tasks" :key="task.id">
            <hgroup>
                <h2>{{ format(task) }}</h2>
                <h3>{{ formatStatus(task) }}</h3>
            </hgroup>
            <div class="grid">
                <button class="contrast" v-on:click="switchStatus(task)" v-bind:aria-busy="task.busy"
                    v-bind:disabled="task.busy">Siguiente</button>
                <button class="secondary" v-on:click="deleteTask(task)" v-bind:aria-busy="task.busy"
                    v-bind:disabled="task.busy">Borrar</button>
            </div>
        </section>
    </div>
    <div v-if="data.mode == 1">
        <form v-on:submit.prevent="append">
            <label>
                Descripción
                <input type="text" v-model="data.description">
            </label>
            <div class="grid">
                <button type="submit" v-bind:disabled="data.busy">Agregar</button>
                <button v-on:click="operationalMode" class="secondary" v-bind:disabled="data.busy">Volver</button>
            </div>
        </form>
    </div>
</template>
    
<script>

import { reactive, onMounted } from "vue";
import { supermarketList_backend } from "../../declarations/supermarketList_backend";
import { uuid } from "./id.js";

export default {

    setup() {
        const data = reactive({
            name: "",
            greeting: "",
            status: [],
            tasks: [],
            description: "",
            mode: 0,
            busy: false,
        });

        function appendMode() {
            data.description = "";
            data.mode = 1;
            data.busy = false;
        }

        async function operationalMode() {
            data.mode = 0;
            await refresh();
        }

        async function enumerateStatus() {
            console.log(data.status);
            if (data.status.length == 0) {
                data.status = await supermarketList_backend.enumerateStatus();
                console.log(data.status);
            }
        }

        async function refresh() {
            data.busy = true;
            data.tasks = await supermarketList_backend.getAllTastks();
            data.busy = false;
        }

        async function append() {
            if (!data.description) return;
            data.busy = true;
            let description = data.description;
            data.description = "";
            await supermarketList_backend.createTask(uuid(), description);
            data.busy = false;
        }

        async function switchStatus(task) {
            task.busy = true;
            let newStatus = (task.status + 1) % data.status.length;
            await supermarketList_backend.changeTaskStatus(task.id, newStatus);
            await refresh();
            task.busy = false;
        }

        async function deleteTask(task) {
            task.busy = true;
            await supermarketList_backend.deleteTaskById(task.id);
            refresh();
        }

        function format(task) {
            return `${task.description}`;
        }

        function formatStatus(task) {
            return `${data.status[task.status]}`;
        }

        onMounted(enumerateStatus);

        return {
            data,
            append,
            refresh,
            enumerateStatus,
            appendMode,
            operationalMode,
            switchStatus,
            format,
            formatStatus,
            deleteTask
        };
    },

}
</script>