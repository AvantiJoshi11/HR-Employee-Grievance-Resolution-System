import { LightningElement, wire } from 'lwc';
import getCaseStats from '@salesforce/apex/GrievanceController.getCaseStats';
import getGrievanceTypeDistribution from '@salesforce/apex/GrievanceController.getGrievanceTypeDistribution';
import { loadScript } from 'lightning/platformResourceLoader';

export default class GrievanceHome extends LightningElement {
    stats = {};
    chartData = [];
    chartInitialized = false;

    @wire(getCaseStats) wiredStats({ error, data }) {
        if (data) this.stats = data;
    }

    @wire(getGrievanceTypeDistribution) wiredChart({ error, data }) {
        if (data) {
            this.chartData = data.map(item => ({ label: item.type, value: item.count }));
            this.initializeChart();
        }
    }

    renderedCallback() {
        if (this.chartInitialized) return;
        this.chartInitialized = true;
        loadScript(this, 'https://cdn.jsdelivr.net/npm/chart.js')
            .then(() => this.initializeChart())
            .catch(error => console.error('Error loading Chart.js', error));
    }

    initializeChart() {
        if (!window.Chart || this.chartData.length === 0) return;
        const ctx = this.template.querySelector('canvas').getContext('2d');
        new window.Chart(ctx, {
            type: 'pie',
            data: {
                labels: this.chartData.map(d => d.label),
                datasets: [{ data: this.chartData.map(d => d.value), backgroundColor: ['#0070D2', '#00A1E0', '#32CD32', '#FFB347'] }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });
    }
}