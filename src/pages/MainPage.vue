<template>
  <q-page class="row justify-evenly main-page">
    <div class="main-page__wrapper main-page--border-radius-16 bg-white shadow-3">
      <div class="main-page__header">
        <h1 class="main-page__header-title">
          Métricas
        </h1>

        <div class="main-page__search-input-wrapper">
          <q-input size="md" v-model="search" type="search" placeholder="Pesquisar" outlined class="main-page__search-input--size">
            <template v-slot:prepend>
              <q-icon name="search" />
            </template>
          </q-input>

          <q-select outlined v-model="selectedFilter" :options="filterOptions" label="Filtros" class="main-page__search-input--size q-ml-md" />
        </div>
      </div>

      <q-separator class="q-mt-md" />

      <div class="main-page__metrics-wrapper">
        <div class="main-page__dropout-risk-wrapper">
          <div class="main-page__global-dropout-status">
            <span class="main-page__dropout-risk-percentage">
              87%
            </span>

            <span>
              Sua universidade está saudável!
            </span>
          </div>

          <div class="main-page__dropout-actionable-wrapper">
            <span class="main-page__dropout-actionable-title">
              Você tem 3.769 alunos com risco de evasão por desempenho
            </span>

            <span class="main-page__dropout-actionable-tip">
              Você pode reverter até 43% desses alunos em risco de evasão através do nosso chatbot
            </span>

            <div class="main-page__dropout-actionable-actions">
              <q-btn color="primary" label="Reduzir risco" />

              <q-btn outline color="primary" label="Acessar painel" class="q-ml-md" />
            </div>
          </div>
        </div>

        <div class="main-page__revenue-risk-wrapper">
          <h3 class="main-page__metrics-title">
            Receita em risco
          </h3>

          <div class="main-page__revenue-wrapper">
            <q-icon name="calendar_month" size="xl" color="red" />

            <div class="main-page__revenue-info q-ml-sm">
              <span>Receita mensal</span>

              <span class="main-page__revenue-value">R$ 476.239,00</span>
            </div>
          </div>

          <div class="main-page__revenue-wrapper">
            <q-icon name="trending_down" size="xl" color="red" />

            <div class="main-page__revenue-info q-ml-sm">
              <span>Receita anual</span>

              <span class="main-page__revenue-value">R$ 3.468.283,00</span>
            </div>
          </div>

          <div class="q-mt-md">
            <q-btn color="primary" label="Reduzir risco" />

            <q-btn outline color="primary" label="Acessar painel" class="q-ml-md" />
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'

const search = ref('')
const selectedFilter = ref('')
const filterOptions = reactive([])
</script>

<style lang="scss" scoped>
.main-page--border-radius-16 {
  border-radius: 16px;
}

.main-page {
  padding: 16px;
}

.main-page__wrapper {
  width: 100%;
  padding: 40px;
}

.main-page__header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.main-page__header-title {
  font-size: 32px;
  font-style: normal;
  font-weight: 500;
  line-height: 32px;
}

.main-page__search-input-wrapper {
  display: flex;
  align-items: center;
}

.main-page__search-input--size {
  width: 170px;
}

.main-page__metrics-wrapper {
  margin-top: 24px;
  display: flex;
  align-items: flex-start;
  gap: 24px;
  align-self: stretch;
}

.main-page__metrics-title {
  margin: 0;
  color: #242A2E;
  font-size: 24px;
  font-style: normal;
}

.main-page__revenue-wrapper {
  display: flex;
  padding: 16px;
  align-items: flex-start;
  gap: 16px;
  align-self: stretch;
  border-radius: 8px;
  background: #F5F8FF;
}

.main-page__revenue-info {
  display: flex;
  flex-direction: column;
}

.main-page__revenue-value {
  font-size: 28px;
  font-style: normal;
  font-weight: 700;
}

.main-page__dropout-risk-wrapper {
  display: flex;
  padding: 24px;
  align-items: flex-start;
  gap: 24px;
  flex: 1 0 0;
  align-self: stretch;
  border-radius: 16px;
  border: 1px solid #D5D9E0;
}

.main-page__global-dropout-status {
  display: flex;
  width: 156px;
  padding: 24px;
  flex-direction: column;
  justify-content: space-between;
  align-items: flex-start;
  align-self: stretch;
  border-radius: 12px;
  background: #9DEEB2;
}

.main-page__dropout-risk-percentage {
  align-self: center;
  font-size: 48px;
  font-style: normal;
  font-weight: 700;
  line-height: 52px;
}

.main-page__dropout-actionable-wrapper {
  display: flex;
  padding: 24px;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  gap: 24px;
  flex: 1 0 0;
  align-self: stretch;
  border-radius: 16px;
  background: #FCEACF;
}

.main-page__dropout-actionable-title {
  flex: 1 0 0;
  color: #805507;
  font-size: 24px;
  font-style: normal;
  font-weight: 600;
  line-height: 28px;
}

.main-page__dropout-actionable-tip {
  align-self: stretch;
  color: #805507;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 24px;
}

.main-page__dropout-actionable-actions {
  display: flex;
  align-items: flex-end;
  gap: 16px;
}

.main-page__revenue-risk-wrapper {
  display: flex;
  padding: 24px;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  gap: 16px;
  align-self: stretch;
  border-radius: 16px;
  border: 1px solid #D5D9E0;
  background: #FFF;
}
</style>
