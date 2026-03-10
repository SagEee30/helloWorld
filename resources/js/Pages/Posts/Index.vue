<script setup>
import { Link, router } from '@inertiajs/vue3'

defineProps({
    posts: Array,
})

function destroy(id) {
    if (confirm('Are you sure you want to delete this post?')) {
        router.delete(`/posts/${id}`)
    }
}
</script>

<template>
    <div class="min-h-screen bg-gradient-to-br from-indigo-50 via-white to-cyan-50 py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <!-- Ambient Background Orbs -->
        <div class="absolute top-0 -left-4 w-72 h-72 bg-purple-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob"></div>
        <div class="absolute top-0 -right-4 w-72 h-72 bg-cyan-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-2000"></div>
        <div class="absolute -bottom-8 left-20 w-72 h-72 bg-pink-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-4000"></div>

        <div class="max-w-4xl mx-auto relative z-10">
            <!-- Header Section -->
            <div class="flex justify-between items-center mb-10 pb-6 border-b border-gray-200/50">
                <div>
                    <h1 class="text-4xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-cyan-600">
                        Recent Signals
                    </h1>
                    <p class="mt-2 text-sm text-gray-500 font-medium">Discover the latest updates and discussions.</p>
                </div>
                <Link href="/posts/create" class="inline-flex items-center justify-center px-6 py-3 border border-transparent text-sm font-medium rounded-xl text-white bg-gradient-to-r from-indigo-600 to-blue-600 hover:from-indigo-700 hover:to-blue-700 shadow-md hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    <svg class="w-5 h-5 mr-2 -ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                    Publish New
                </Link>
            </div>

            <!-- Empty State -->
            <div v-if="posts.length === 0" class="flex flex-col items-center justify-center py-16 px-4 bg-white/60 backdrop-blur-xl rounded-3xl border border-white/50 shadow-xl shadow-indigo-100/50">
                <div class="w-24 h-24 mb-6 rounded-full bg-gradient-to-br from-indigo-100 to-cyan-100 flex items-center justify-center text-indigo-500 shadow-inner">
                    <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 002-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-2">No signals yet</h3>
                <p class="text-gray-500 text-center max-w-sm mb-6">Get started by creating your first post and sharing your thoughts with the world.</p>
                <Link href="/posts/create" class="text-indigo-600 font-semibold hover:text-indigo-800 transition-colors">
                    Create the first one &rarr;
                </Link>
            </div>

            <!-- Cards Listing -->
            <div v-else class="space-y-6">
                <div v-for="post in posts" :key="post.id" class="group bg-white/70 backdrop-blur-lg rounded-2xl border border-white/60 shadow-md hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 overflow-hidden">
                    <div class="p-8">
                        <div class="flex justify-between items-start gap-6">
                            <div class="flex-1">
                                <Link :href="`/posts/${post.id}`" class="block group-hover:text-indigo-600 transition-colors">
                                    <h2 class="text-2xl font-bold text-gray-900 mb-3 line-clamp-1">
                                        {{ post.title }}
                                    </h2>
                                </Link>
                                <p class="text-gray-600 leading-relaxed text-base line-clamp-3">
                                    {{ post.body }}
                                </p>
                            </div>
                            
                            <!-- Actions -->
                            <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-3 opacity-0 group-hover:opacity-100 transition-opacity duration-300 transform translate-x-4 group-hover:translate-x-0 shrink-0">
                                <Link :href="`/posts/${post.id}/edit`" class="inline-flex items-center justify-center px-4 py-2 border border-gray-200 text-sm font-medium rounded-lg text-gray-700 bg-white hover:bg-gray-50 hover:text-indigo-600 hover:border-indigo-200 transition-all shadow-sm">
                                    Edit
                                </Link>
                                <button @click="destroy(post.id)" class="inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg text-red-600 bg-red-50 hover:bg-red-100 transition-all shadow-sm">
                                    Delete
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- Subtle bottom gradient line -->
                    <div class="h-1 w-full bg-gradient-to-r from-indigo-500 via-purple-500 to-cyan-500 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                </div>
            </div>
        </div>
    </div>
</template>
