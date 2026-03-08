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
    <div class="max-w-2xl mx-auto py-8 px-4">
        <div class="flex items-center mb-6">
            <Link href="/posts" class="text-blue-600 hover:underline mr-4">&larr; Back</Link>
        </div>

        <div class="bg-white shadow rounded-lg p-6">
            <h1 class="text-3xl font-bold text-gray-900 mb-4">{{ post.title }}</h1>
            <p class="text-gray-500 text-sm mb-4">
                Created {{ new Date(post.created_at).toLocaleDateString() }}
            </p>
            <div class="mb-6">
                <p class="text-gray-700 whitespace-pre-wrap">{{ post.body }}</p>
            </div>
            <div class="flex space-x-2">
                <Link :href="`/posts/${post.id}/edit`" class="bg-yellow-500 text-white px-4 py-2 rounded-lg hover:bg-yellow-600 transition">
                    Edit
                </Link>
                <button @click="destroy" class="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 transition">
                    Delete
                </button>
            </div>
        </div>
    </div>
</template>
