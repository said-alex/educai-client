<template>
  <q-page class="row justify-evenly main-page">
    <div class="main-page__wrapper main-page--border-radius-16 bg-white shadow-3">
      <div class="main-page__header">
        <h1 class="main-page__header-title">
          Métricas
        </h1>

        <div class="main-page__search-input-wrapper">
          <q-select outlined v-model="selectedFilter" :options="filterOptions" label="Filtros" class="main-page__search-input--size q-ml-md" />
        </div>
      </div>

      <q-separator class="q-mt-md" />

      <div class="main-page__metrics-wrapper">
        <div class="main-page__dropout-risk-wrapper">
          <div :class="[
            'main-page__global-dropout-status',
            dropoutRiskWrapperBgColor
          ]">
            <span class="main-page__dropout-risk-percentage">
              {{ formattedDropoutRiskPercentage }}
            </span>

            <span>
              {{ dropoutRiskStatusMessage }}
            </span>
          </div>

          <div class="main-page__dropout-actionable-wrapper">
            <h3 class="main-page__dropout-actionable-title">
              Você tem {{ studentsCount }} alunos em risco de evasão por {{ formattedSelectedFilter }}
            </h3>

            <span class="main-page__dropout-actionable-tip">
              Você pode reverter o risco de evasão através do nosso chatbot
            </span>

            <div class="main-page__dropout-actionable-actions">
              <q-btn color="primary" label="Reduzir risco" />
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

              <span class="main-page__revenue-value">{{ formattedMonthlyRevenueInRisk }}</span>
            </div>
          </div>

          <div class="main-page__revenue-wrapper">
            <q-icon name="trending_down" size="xl" color="red" />

            <div class="main-page__revenue-info q-ml-sm">
              <span>Receita anual</span>

              <span class="main-page__revenue-value">{{ formattedYearlyRevenueInRisk }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'

type DropoutMetrics = {
  dropoutRiskPercentage: number
  monthlyRevenueInRisk: number
  yearlyRevenueInRisk: number
}

type DropoutMetricsByCategory = {
  count: number
}

const selectedFilter = ref('Desempenho')

const filterOptions = [
  'Desempenho',
  'Inadimplência',
  'Frequência',
  'Renda',
  'Baixo Engajamento ao AVA'
]

const filterOptionsCategoryMap: { [k: string]: string } = {
  Desempenho: 'performance',
  Inadimplência: 'payment_status',
  Frequência: 'attendance',
  Renda: 'income',
  'Baixo Engajamento ao AVA': 'engagement'
}

const dropoutMetrics = ref<DropoutMetrics>({} as DropoutMetrics)
const studentsCount = ref(0)

const formattedDropoutRiskPercentage = computed(() =>
  `${parseInt(dropoutMetrics.value.dropoutRiskPercentage?.toString())}%`
)

const discreteDropoutRiskPercentage = computed(() => {
  const { dropoutRiskPercentage } = dropoutMetrics.value

  if (dropoutRiskPercentage < 30) {
    return 'low'
  } else if (dropoutRiskPercentage >= 30 && dropoutRiskPercentage < 60) {
    return 'medium'
  } else {
    return 'high'
  }
})
const formattedSelectedFilter = computed(() => selectedFilter.value.toLowerCase())
const formattedMonthlyRevenueInRisk = computed(() => formatCurrency(dropoutMetrics.value.monthlyRevenueInRisk))
const formattedYearlyRevenueInRisk = computed(() => formatCurrency(dropoutMetrics.value.yearlyRevenueInRisk))
const dropoutRiskWrapperBgColor = computed(() => {
  if (discreteDropoutRiskPercentage.value === 'low') {
    return 'bg-green-5'
  } else if (discreteDropoutRiskPercentage.value === 'medium') {
    return 'bg-yellow-5'
  } else {
    return 'bg-red-5'
  }
})
const dropoutRiskStatusMessage = computed(() => {
  if (discreteDropoutRiskPercentage.value === 'low') {
    return 'Sua universidade está saudável!'
  } else if (discreteDropoutRiskPercentage.value === 'medium') {
    return 'Sua universidade está em risco!'
  } else {
    return 'Sua universidade está em risco crítico!'
  }
})
const formatCurrency = (value: number) => value?.toLocaleString('pt-br', { style: 'currency', currency: 'BRL' })

const fetchDropoutMetrics = async () => await fetch('http://localhost:8000/students/dropout_metrics')
  .then(response => response.json())
  .then((data: DropoutMetrics) => { dropoutMetrics.value = data })

const fetchDropoutMetricsByCategory = async (category: string) =>
  await fetch(`http://localhost:8000/students/${filterOptionsCategoryMap[category]}`)
    .then(response => response.json())
    .then((data: DropoutMetricsByCategory) => { studentsCount.value = data.count })
    .catch(() => { studentsCount.value = 0 })

watch(selectedFilter, async () => {
  await fetchDropoutMetricsByCategory(selectedFilter.value)
})

onMounted(async () => {
  await fetchDropoutMetrics()
  await fetchDropoutMetricsByCategory(selectedFilter.value)
})
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
  width: 240px;
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
