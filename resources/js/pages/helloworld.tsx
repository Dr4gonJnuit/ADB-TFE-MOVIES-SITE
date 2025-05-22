import { Head } from '@inertiajs/react';

export default function HelloWorld() {
    return (
        <>
            <Head title="Hello World!">
                <link rel="preconnect" href="https://fonts.bunny.net" />
                <link href="https://fonts.bunny.net/css?family=instrument-sans:400,500,600" rel="stylesheet" />
            </Head>
            <div className="flex h-full flex-1 flex-col gap-4 rounded-xl p-4">
                <div className="grid auto-rows-min gap-4 md:grid-cols-3">
                    <div className="border-sidebar-border/70 dark:border-sidebar-border relative aspect-video overflow-hidden rounded-xl border">
                        <h1>Hello World!</h1>
                    </div>
                </div>
            </div>
        </>
    );
}
