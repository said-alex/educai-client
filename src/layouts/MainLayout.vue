<template>
  <q-layout view="lHh lpR lFf" class="bg-blue-grey-1">
    <q-drawer show-if-above :v-model="true" side="left" class="bg-blue-grey-1">
      <h3>IMAGINE UMA SIDEBAR BEM ESTILOSA NESSA ÁREA :D</h3>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>
