<script>
  import Proposal from "./Proposal.svelte"
  import { get } from "svelte/store"
  import { daoActor, principal } from "../stores"
  import { onMount } from "svelte"

  let proposals = []

  async function get_all_proposals() {
    let dao = get(daoActor)
    if (!dao) {
      return
    }
    let res = await dao.get_all_proposals()
    console.log("Proposals", res)
    return res
  }
  let promise = get_all_proposals()
  onMount(async () => {
    proposals = await get_all_proposals()
    console.log(proposals)
  })
</script>

{#if $principal}
  {#each proposals as proposal}
    <div>ID: {proposal[0]}; Payload : {proposal[1].payload} </div>
  {/each} 
  <!-- {#await promise}
    <p>Loading...</p>
  {:then proposals}
    <div id="proposals">
      <h1>Proposals</h1>
      {#each proposals as post}
        <Proposal {post} />
      {/each}
    </div>
  {:catch error}
    <p style="color: red">{error.message}</p>
  {/await} -->
{:else}
  <p class="example-disabled">Connect with a wallet to access this example</p>
{/if}

<style>
  h1 {
    color: white;
    font-size: 10vmin;
    font-weight: 700;
  }

  #proposals {
    display: flex;
    flex-direction: column;
    width: 100%;
    margin-left: 10vmin;
  }
</style>
