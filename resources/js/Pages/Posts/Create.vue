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
    <div class="max-w-2xl mx-auto py-8 px-4">
        <div class="flex items-center mb-6">
            <Link href="/posts" class="text-blue-600 hover:underline mr-4">&larr; Back</Link>
            <h1 class="text-3xl font-bold text-gray-900">Create Post</h1>
        </div>

        <form @submit.prevent="submit" class="bg-white shadow rounded-lg p-6 space-y-4">
            <div>
                <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Title</label>
                <input
                    id="title"
                    v-model="form.title"
                    type="text"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Enter post title"
                />
                <p v-if="form.errors.title" class="text-red-500 text-sm mt-1">{{ form.errors.title }}</p>
            </div>

            <div>
                <label for="body" class="block text-sm font-medium text-gray-700 mb-1">Body</label>
                <textarea
                    id="body"
                    v-model="form.body"
                    rows="6"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Enter post content"
                ></textarea>
                <p v-if="form.errors.body" class="text-red-500 text-sm mt-1">{{ form.errors.body }}</p>
            </div>

            <button
                type="submit"
                :disabled="form.processing"
                class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 disabled:opacity-50 transition"
            >
                Create Post
            </button>
        </form>
    </div>
</template>
