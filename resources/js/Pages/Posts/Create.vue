<script setup>
import { useForm, Link } from '@inertiajs/vue3'

const form = useForm({
    title: '',
    body: '',
})

function submit() {
    form.post('/posts')
}
</script>

<template>
    <div class="min-h-screen bg-gradient-to-br from-indigo-50 via-white to-cyan-50 py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
        <!-- Ambient Background Orbs -->
        <div class="absolute top-0 -left-4 w-72 h-72 bg-purple-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob"></div>
        <div class="absolute top-0 -right-4 w-72 h-72 bg-cyan-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-2000"></div>
        <div class="absolute -bottom-8 left-20 w-72 h-72 bg-pink-300 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-4000"></div>

        <div class="max-w-2xl mx-auto relative z-10">
            <div class="mb-10">
                <Link href="/posts" class="inline-flex items-center text-sm font-medium text-indigo-600 hover:text-indigo-800 transition-colors mb-4">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                    Back to Signals
                </Link>
                <h1 class="text-4xl font-extrabold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-cyan-600">
                    Create New Signal
                </h1>
                <p class="mt-2 text-sm text-gray-500 font-medium">Broadcast your thoughts to the network.</p>
            </div>

            <form @submit.prevent="submit" class="bg-white/70 backdrop-blur-xl shadow-xl shadow-indigo-100/50 rounded-3xl border border-white/60 p-8 sm:p-10 relative overflow-hidden">
                <!-- Decorative subtle top border -->
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-indigo-400 to-cyan-400"></div>

                <div class="space-y-6">
                    <div>
                        <label for="title" class="block text-sm font-bold text-gray-700 mb-2 tracking-wide uppercase">Title</label>
                        <input
                            id="title"
                            v-model="form.title"
                            type="text"
                            class="w-full bg-white/50 border border-gray-200 focus:border-indigo-400 focus:ring-4 focus:ring-indigo-500/10 rounded-xl px-4 py-3 text-gray-900 transition-all duration-300 placeholder-gray-400 shadow-sm"
                            placeholder="A captivating headline..."
                        />
                        <p v-if="form.errors.title" class="text-red-500 text-sm mt-2 font-medium flex items-center">
                            <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>
                            {{ form.errors.title }}
                        </p>
                    </div>

                    <div>
                        <label for="body" class="block text-sm font-bold text-gray-700 mb-2 tracking-wide uppercase">Body</label>
                        <textarea
                            id="body"
                            v-model="form.body"
                            rows="8"
                            class="w-full bg-white/50 border border-gray-200 focus:border-indigo-400 focus:ring-4 focus:ring-indigo-500/10 rounded-xl px-4 py-3 text-gray-900 transition-all duration-300 placeholder-gray-400 shadow-sm resize-y"
                            placeholder="Share your detailed message here..."
                        ></textarea>
                        <p v-if="form.errors.body" class="text-red-500 text-sm mt-2 font-medium flex items-center">
                            <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path></svg>
                            {{ form.errors.body }}
                        </p>
                    </div>
                </div>

                <div class="mt-10 pt-6 border-t border-gray-100 flex items-center justify-end">
                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="inline-flex items-center justify-center px-8 py-3 border border-transparent text-base font-bold rounded-xl text-white bg-gradient-to-r from-indigo-600 to-blue-600 hover:from-indigo-700 hover:to-blue-700 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 w-full sm:w-auto"
                    >
                        Publish Post
                    </button>
                </div>
            </form>
        </div>
    </div>
</template>
