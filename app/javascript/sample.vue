
<script>
export default {
  el: "#app",
  data: {
    isActive: '1'
  },
  methods: {
    change: function(num){
      this.isActive = num
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
