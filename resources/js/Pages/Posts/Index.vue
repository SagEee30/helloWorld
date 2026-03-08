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
    <div class="max-w-4xl mx-auto py-8 px-4">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-900">Posts</h1>
            <Link href="/posts/create" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition">
                + New Post
            </Link>
        </div>

        <div v-if="posts.length === 0" class="text-gray-500 text-center py-12 bg-white rounded-lg shadow">
            No posts yet. Create your first post!
        </div>

        <div v-else class="space-y-4">
            <div v-for="post in posts" :key="post.id" class="bg-white shadow rounded-lg p-6">
                <div class="flex justify-between items-start">
                    <div class="flex-1">
                        <Link :href="`/posts/${post.id}`" class="text-xl font-semibold text-blue-600 hover:underline">
                            {{ post.title }}
                        </Link>
                        <p class="text-gray-600 mt-2">
                            {{ post.body.substring(0, 150) }}{{ post.body.length > 150 ? '...' : '' }}
                        </p>
                    </div>
                    <div class="flex space-x-2 ml-4 shrink-0">
                        <Link :href="`/posts/${post.id}/edit`" class="text-sm bg-yellow-500 text-white px-3 py-1.5 rounded hover:bg-yellow-600 transition">
                            Edit
                        </Link>
                        <button @click="destroy(post.id)" class="text-sm bg-red-500 text-white px-3 py-1.5 rounded hover:bg-red-600 transition">
                            Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
