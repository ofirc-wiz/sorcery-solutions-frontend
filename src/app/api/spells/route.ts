import { NextRequest, NextResponse } from 'next/server';

const API_BASE_URL = process.env.API_BASE_URL || 'http://localhost:3000';

export async function POST(req: NextRequest) {
    const body = await req.json();

    const res = await fetch(`${API_BASE_URL}/api/spells`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body),
    });

    const data = await res.json();
    return NextResponse.json(data, { status: res.status });
}

export async function GET() {
    const res = await fetch(`${API_BASE_URL}/api/spells`);
    const data = await res.json();
    return NextResponse.json(data, { status: res.status });
}
