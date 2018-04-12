<template>
  <div id="app">
    <div id="questions">
      <button v-for="q in activeQs" type="button">{{ q }}</button>
    </div>
  </div>
</template>

<script>
import HelloWorld from "./components/HelloWorld.vue";

export default {
  name: "app",
  components: {
    HelloWorld
  },
  data: () => {
    return {
      allQ: {
        A: "Can the case be reduced by a recent Proposition?",
        B: "Question B",
        C: "Question C",
      },
      activeQKeys: ["A", "B"] 
    };
  },
  computed: {
    activeQs: function () {
      // return this.allQ.filter(q => activeQKeys.includes(q));
      return this.activeQKeys.map(key => this.allQ[key]);
      // return this.activeQKeys.filter(q => activeQKeys.includes(q));
    }
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
