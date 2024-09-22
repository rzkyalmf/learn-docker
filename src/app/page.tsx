import prisma from "@/utils/prisma";

export default async function Home() {
  const notes = await prisma.note.findMany();

  return (
    <div>
      <h1>Hello World 2 !</h1>
      <div>
        {notes.map((note) => (
          <p key={note.id}>{note.content}</p>
        ))}
      </div>
    </div>
  );
}
