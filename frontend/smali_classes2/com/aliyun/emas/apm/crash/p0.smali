.class Lcom/aliyun/emas/apm/crash/p0;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/a0;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/p0$b;
    }
.end annotation


# static fields
.field private static final d:Ljava/nio/charset/Charset;


# instance fields
.field private final a:Ljava/io/File;

.field private final b:I

.field private c:Lcom/aliyun/emas/apm/crash/o0;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "UTF-8"

    .line 1
    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/p0;->d:Ljava/nio/charset/Charset;

    return-void
.end method

.method constructor <init>(Ljava/io/File;I)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/p0;->a:Ljava/io/File;

    iput p2, p0, Lcom/aliyun/emas/apm/crash/p0;->b:I

    return-void
.end method

.method private b(JLjava/lang/String;)V
    .locals 4

    const-string v0, " "

    const-string v1, "..."

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    if-nez v2, :cond_0

    return-void

    :cond_0
    if-nez p3, :cond_1

    const-string p3, "null"

    :cond_1
    :try_start_0
    iget v2, p0, Lcom/aliyun/emas/apm/crash/p0;->b:I

    .line 27
    div-int/lit8 v2, v2, 0x4

    .line 29
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v3

    if-le v3, v2, :cond_2

    .line 30
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, v2

    invoke-virtual {p3, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    :cond_2
    const-string v1, "\r"

    .line 33
    invoke-virtual {p3, v1, v0}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    const-string v1, "\n"

    .line 34
    invoke-virtual {p3, v1, v0}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    .line 36
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v1, "%d %s%n"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const/4 p2, 0x0

    aput-object p1, v2, p2

    const/4 p1, 0x1

    aput-object p3, v2, p1

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    sget-object p2, Lcom/aliyun/emas/apm/crash/p0;->d:Ljava/nio/charset/Charset;

    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p1

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 38
    invoke-virtual {p2, p1}, Lcom/aliyun/emas/apm/crash/o0;->a([B)V

    :goto_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 41
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/o0;->b()Z

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/o0;->f()I

    move-result p1

    iget p2, p0, Lcom/aliyun/emas/apm/crash/p0;->b:I

    if-le p1, p2, :cond_3

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 42
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/o0;->e()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 45
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string p3, "There was a problem writing to the Crashlytics log."

    invoke-virtual {p2, p3, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_3
    return-void
.end method

.method private d()Lcom/aliyun/emas/apm/crash/p0$b;
    .locals 6

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/p0;->a:Ljava/io/File;

    .line 1
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 6
    :cond_0
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/p0;->e()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    if-nez v0, :cond_1

    return-object v1

    :cond_1
    const/4 v1, 0x0

    filled-new-array {v1}, [I

    move-result-object v2

    .line 18
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/o0;->f()I

    move-result v0

    new-array v0, v0, [B

    :try_start_0
    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 21
    new-instance v4, Lcom/aliyun/emas/apm/crash/p0$a;

    invoke-direct {v4, p0, v0, v2}, Lcom/aliyun/emas/apm/crash/p0$a;-><init>(Lcom/aliyun/emas/apm/crash/p0;[B[I)V

    invoke-virtual {v3, v4}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0$d;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    .line 34
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v4

    const-string v5, "A problem occurred while reading the Crashlytics log file."

    invoke-virtual {v4, v5, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 37
    :goto_0
    new-instance v3, Lcom/aliyun/emas/apm/crash/p0$b;

    aget v1, v2, v1

    invoke-direct {v3, v0, v1}, Lcom/aliyun/emas/apm/crash/p0$b;-><init>([BI)V

    return-object v3
.end method

.method private e()V
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    if-nez v0, :cond_0

    .line 3
    :try_start_0
    new-instance v0, Lcom/aliyun/emas/apm/crash/o0;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/p0;->a:Ljava/io/File;

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/crash/o0;-><init>(Ljava/io/File;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 5
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Could not open log file: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/p0;->a:Ljava/io/File;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 3

    .line 3
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/p0;->c()[B

    move-result-object v0

    if-eqz v0, :cond_0

    .line 4
    new-instance v1, Ljava/lang/String;

    sget-object v2, Lcom/aliyun/emas/apm/crash/p0;->d:Ljava/nio/charset/Charset;

    invoke-direct {v1, v0, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1
.end method

.method public a(JLjava/lang/String;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/p0;->e()V

    .line 2
    invoke-direct {p0, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/p0;->b(JLjava/lang/String;)V

    return-void
.end method

.method public b()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    const-string v1, "There was a problem closing the Crashlytics log file."

    .line 1
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;Ljava/lang/String;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/p0;->c:Lcom/aliyun/emas/apm/crash/o0;

    return-void
.end method

.method public c()[B
    .locals 4

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/p0;->d()Lcom/aliyun/emas/apm/crash/p0$b;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 5
    :cond_0
    iget v1, v0, Lcom/aliyun/emas/apm/crash/p0$b;->b:I

    new-array v2, v1, [B

    .line 6
    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/p0$b;->a:[B

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method
