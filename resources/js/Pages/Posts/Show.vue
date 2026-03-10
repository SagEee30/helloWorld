<script setup>
import { Link, router } from '@inertiajs/vue3'

const props = defineProps({
    post: Object,
})

function destroy() {
    if (confirm('Are you sure you want to delete this post?')) {
        router.delete(`/posts/${props.post.id}`)
    }
}
</script>

<template>
    <div class="min-h-screen bg-gradient-to-br from-indigo-50 via-white to-cyan-50 py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <!-- Ambient Background Orbs -->
        <div class="absolute top-0 -left-4 w-72 h-72 bg-purple-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob"></div>
        <div class="absolute top-0 -right-4 w-72 h-72 bg-cyan-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-2000"></div>
        <div class="absolute -bottom-8 left-20 w-72 h-72 bg-pink-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-4000"></div>

        <div class="max-w-3xl mx-auto relative z-10">
            <div class="mb-10">
                <Link href="/posts" class="inline-flex items-center text-sm font-medium text-indigo-600 hover:text-indigo-800 transition-colors mb-4 bg-white/50 px-3 py-1.5 rounded-full border border-indigo-100 shadow-sm">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                    Back to Signals
                </Link>
            </div>

            <article class="bg-white/70 backdrop-blur-xl shadow-xl shadow-indigo-100/50 rounded-3xl border border-white/60 p-8 sm:p-12 relative overflow-hidden">
                <!-- Decorative subtle top border -->
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-indigo-500 via-purple-500 to-cyan-500"></div>

                <header class="mb-8 pb-8 border-b border-gray-100">
                    <h1 class="text-4xl sm:text-5xl font-extrabold text-gray-900 tracking-tight leading-tight mb-4">
                        {{ post.title }}
                    </h1>
                    <div class="flex items-center text-sm text-gray-500 bg-gray-50/50 rounded-lg inline-flex px-3 py-2 border border-gray-100">
                        <svg class="w-4 h-4 mr-2 text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                        Broadcasted on <time class="ml-1 font-semibold text-gray-700">{{ new Date(post.created_at).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }) }}</time>
                    </div>
                </header>

                <div class="prose prose-lg prose-indigo max-w-none mb-12 text-gray-700 leading-relaxed whitespace-pre-wrap">
                    {{ post.body }}
                </div>

                <footer class="mt-10 pt-6 border-t border-gray-100 flex flex-col sm:flex-row items-center justify-between gap-4">
                    <div class="text-sm text-gray-400 font-medium">
                        Signal ID: #{{ post.id }}
                    </div>
                    <div class="flex space-x-3 w-full sm:w-auto">
                        <Link :href="`/posts/${post.id}/edit`" class="flex-1 sm:flex-none inline-flex items-center justify-center px-6 py-2.5 border border-transparent text-sm font-bold rounded-xl text-white bg-gradient-to-r from-yellow-500 to-orange-500 hover:from-yellow-600 hover:to-orange-600 shadow-md hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                            Edit
                        </Link>
                        <button @click="destroy" class="flex-1 sm:flex-none inline-flex items-center justify-center px-6 py-2.5 border border-transparent text-sm font-bold rounded-xl text-red-600 bg-red-50 hover:bg-red-100 border border-red-100 hover:border-red-200 transition-all duration-200">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                            Delete
                        </button>
                    </div>
                </footer>
            </article>
        </div>
    </div>
</template>
