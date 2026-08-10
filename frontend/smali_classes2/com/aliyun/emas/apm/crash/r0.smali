.class final Lcom/aliyun/emas/apm/crash/r0;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/r0$b;
    }
.end annotation


# static fields
.field private static final m:Lcom/aliyun/emas/apm/crash/p;


# instance fields
.field private final a:D

.field private final b:D

.field private final c:J

.field private final d:J

.field private final e:I

.field private final f:Ljava/util/concurrent/BlockingQueue;

.field private final g:Ljava/util/concurrent/ThreadPoolExecutor;

.field private final h:Lcom/aliyun/emas/apm/crash/m0;

.field private final i:Lcom/aliyun/emas/apm/crash/b0;

.field private final j:Lcom/aliyun/emas/apm/ApmOptions;

.field private k:I

.field private l:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/p;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/p;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/r0;->m:Lcom/aliyun/emas/apm/crash/p;

    return-void
.end method

.method constructor <init>(DDJLcom/aliyun/emas/apm/crash/m0;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/ApmOptions;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/r0;->a:D

    iput-wide p3, p0, Lcom/aliyun/emas/apm/crash/r0;->b:D

    iput-wide p5, p0, Lcom/aliyun/emas/apm/crash/r0;->c:J

    iput-object p7, p0, Lcom/aliyun/emas/apm/crash/r0;->h:Lcom/aliyun/emas/apm/crash/m0;

    iput-object p8, p0, Lcom/aliyun/emas/apm/crash/r0;->i:Lcom/aliyun/emas/apm/crash/b0;

    iput-object p9, p0, Lcom/aliyun/emas/apm/crash/r0;->j:Lcom/aliyun/emas/apm/ApmOptions;

    .line 10
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide p3

    iput-wide p3, p0, Lcom/aliyun/emas/apm/crash/r0;->d:J

    double-to-int p1, p1

    iput p1, p0, Lcom/aliyun/emas/apm/crash/r0;->e:I

    .line 14
    new-instance p8, Ljava/util/concurrent/ArrayBlockingQueue;

    invoke-direct {p8, p1}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    iput-object p8, p0, Lcom/aliyun/emas/apm/crash/r0;->f:Ljava/util/concurrent/BlockingQueue;

    .line 15
    new-instance p1, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object p7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const/4 p3, 0x1

    const/4 p4, 0x1

    const-wide/16 p5, 0x0

    move-object p2, p1

    invoke-direct/range {p2 .. p8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/r0;->g:Ljava/util/concurrent/ThreadPoolExecutor;

    const/4 p1, 0x0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/r0;->k:I

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/r0;->l:J

    return-void
.end method

.method constructor <init>(Lcom/aliyun/emas/apm/crash/v0;Lcom/aliyun/emas/apm/crash/m0;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/ApmOptions;)V
    .locals 10

    .line 1
    iget-wide v1, p1, Lcom/aliyun/emas/apm/crash/v0;->f:D

    iget-wide v3, p1, Lcom/aliyun/emas/apm/crash/v0;->g:D

    iget p1, p1, Lcom/aliyun/emas/apm/crash/v0;->h:I

    int-to-long v5, p1

    const-wide/16 v7, 0x3e8

    mul-long/2addr v5, v7

    move-object v0, p0

    move-object v7, p2

    move-object v8, p3

    move-object v9, p4

    invoke-direct/range {v0 .. v9}, Lcom/aliyun/emas/apm/crash/r0;-><init>(DDJLcom/aliyun/emas/apm/crash/m0;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/ApmOptions;)V

    return-void
.end method

.method private a()D
    .locals 6

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/r0;->a:D

    const-wide v2, 0x40ed4c0000000000L    # 60000.0

    div-double/2addr v2, v0

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/r0;->b:D

    .line 85
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->b()I

    move-result v4

    int-to-double v4, v4

    invoke-static {v0, v1, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    mul-double/2addr v2, v0

    const-wide v0, 0x414b774000000000L    # 3600000.0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(DD)D

    move-result-wide v0

    return-wide v0
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/r0;)Lcom/aliyun/emas/apm/crash/m0;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/r0;->h:Lcom/aliyun/emas/apm/crash/m0;

    return-object p0
.end method

.method private a([B)Ljava/lang/String;
    .locals 2

    .line 82
    invoke-static {p1}, Lcom/aliyun/emas/apm/util/HmacUtils;->getMD5String([B)Ljava/lang/String;

    move-result-object p1

    .line 83
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/r0;->i:Lcom/aliyun/emas/apm/crash/b0;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b0;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/r0;->i:Lcom/aliyun/emas/apm/crash/b0;

    .line 84
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/b0;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/util/HmacUtils;->getHmac(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method static synthetic a(D)V
    .locals 0

    .line 3
    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/r0;->b(D)V

    return-void
.end method

.method private a(Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 5

    const-string v0, "Sending report failed: "

    .line 32
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Sending report : "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 33
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    sget-object v1, Lcom/aliyun/emas/apm/crash/r0;->m:Lcom/aliyun/emas/apm/crash/p;

    .line 35
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->a()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/p;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/r0;->j:Lcom/aliyun/emas/apm/ApmOptions;

    if-eqz v2, :cond_0

    .line 38
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/ApmOptions;->isOnline()Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "https://pre-apm-gateway.aliyuncs.com/log/upload"

    goto :goto_0

    :cond_0
    const-string v2, "https://apm-gateway.aliyuncs.com/log/upload"

    :goto_0
    const/4 v3, 0x0

    .line 43
    :try_start_0
    new-instance v4, Ljava/net/URL;

    invoke-direct {v4, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 45
    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/r0;->b([B)[B

    move-result-object v1

    .line 47
    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    const/16 v3, 0x2710

    .line 48
    :try_start_1
    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setReadTimeout(I)V

    .line 49
    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setConnectTimeout(I)V

    const-string v3, "POST"

    .line 50
    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const/4 v3, 0x1

    .line 51
    invoke-virtual {v2, v3}, Ljava/net/URLConnection;->setDoOutput(Z)V

    const-string v3, "Content-Type"

    const-string v4, "application/octet-stream"

    .line 52
    invoke-virtual {v2, v3, v4}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "x-apm-app-key"

    iget-object v4, p0, Lcom/aliyun/emas/apm/crash/r0;->i:Lcom/aliyun/emas/apm/crash/b0;

    .line 53
    invoke-virtual {v4}, Lcom/aliyun/emas/apm/crash/b0;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "x-apm-signature-algorithm"

    const-string v4, "EMAS-HMAC-V1"

    .line 54
    invoke-virtual {v2, v3, v4}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "x-apm-signature"

    .line 55
    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/r0;->a([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "x-apm-compression"

    const-string v4, "gzip"

    .line 56
    invoke-virtual {v2, v3, v4}, Ljava/net/URLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    invoke-virtual {v2}, Ljava/net/URLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v3

    .line 59
    invoke-virtual {v3, v1}, Ljava/io/OutputStream;->write([B)V

    .line 60
    invoke-virtual {v3}, Ljava/io/OutputStream;->flush()V

    .line 62
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v1

    const/16 v3, 0xc8

    if-ne v1, v3, :cond_1

    .line 63
    invoke-virtual {p2, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    goto :goto_2

    .line 65
    :cond_1
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetException(Ljava/lang/Exception;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p1

    move-object v3, v2

    goto :goto_3

    :catch_0
    move-exception v1

    move-object v3, v2

    goto :goto_1

    :catchall_1
    move-exception p1

    goto :goto_3

    :catch_1
    move-exception v1

    .line 74
    :goto_1
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 75
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 76
    invoke-virtual {p2, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetException(Ljava/lang/Exception;)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    if-eqz v3, :cond_2

    move-object v2, v3

    .line 73
    :goto_2
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_2
    return-void

    :goto_3
    if-eqz v3, :cond_3

    .line 79
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 81
    :cond_3
    throw p1
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/r0;Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/r0;->a(Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    return-void
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/crash/r0;)D
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->a()D

    move-result-wide v0

    return-wide v0
.end method

.method private b()I
    .locals 4

    iget-wide v0, p0, Lcom/aliyun/emas/apm/crash/r0;->l:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    .line 3
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->e()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/crash/r0;->l:J

    .line 6
    :cond_0
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->e()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/aliyun/emas/apm/crash/r0;->l:J

    sub-long/2addr v0, v2

    iget-wide v2, p0, Lcom/aliyun/emas/apm/crash/r0;->c:J

    div-long/2addr v0, v2

    long-to-int v0, v0

    .line 8
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->d()Z

    move-result v1

    if-eqz v1, :cond_1

    iget v1, p0, Lcom/aliyun/emas/apm/crash/r0;->k:I

    add-int/2addr v1, v0

    const/16 v0, 0x64

    .line 9
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    goto :goto_0

    :cond_1
    iget v1, p0, Lcom/aliyun/emas/apm/crash/r0;->k:I

    sub-int/2addr v1, v0

    const/4 v0, 0x0

    .line 10
    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    :goto_0
    iget v1, p0, Lcom/aliyun/emas/apm/crash/r0;->k:I

    if-eq v1, v0, :cond_2

    iput v0, p0, Lcom/aliyun/emas/apm/crash/r0;->k:I

    .line 15
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->e()J

    move-result-wide v1

    iput-wide v1, p0, Lcom/aliyun/emas/apm/crash/r0;->l:J

    :cond_2
    return v0
.end method

.method private static b(D)V
    .locals 0

    double-to-long p0, p0

    .line 16
    :try_start_0
    invoke-static {p0, p1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private b([B)[B
    .locals 2

    .line 17
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 18
    :try_start_0
    new-instance v1, Ljava/util/zip/GZIPOutputStream;

    invoke-direct {v1, v0}, Ljava/util/zip/GZIPOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 19
    :try_start_1
    invoke-virtual {v1, p1}, Ljava/io/OutputStream;->write([B)V

    .line 20
    invoke-virtual {v1}, Ljava/util/zip/GZIPOutputStream;->finish()V

    .line 22
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 23
    :try_start_2
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V

    return-object p1

    :catchall_0
    move-exception p1

    .line 24
    :try_start_3
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v1

    :try_start_4
    invoke-virtual {p1, v1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    :catchall_2
    move-exception p1

    :try_start_5
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    goto :goto_1

    :catchall_3
    move-exception v0

    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p1
.end method

.method private c()Z
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/r0;->f:Ljava/util/concurrent/BlockingQueue;

    .line 1
    invoke-interface {v0}, Ljava/util/Collection;->size()I

    move-result v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/r0;->e:I

    if-ge v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private d()Z
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/r0;->f:Ljava/util/concurrent/BlockingQueue;

    .line 1
    invoke-interface {v0}, Ljava/util/Collection;->size()I

    move-result v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/r0;->e:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private e()J
    .locals 2

    .line 1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    return-wide v0
.end method


# virtual methods
.method a(Lcom/aliyun/emas/apm/crash/q;Z)Lcom/google/android/gms/tasks/TaskCompletionSource;
    .locals 6

    const-string v0, "Closing task for report: "

    const-string v1, "Queue size: "

    const-string v2, "Dropping report due to queue being full: "

    const-string v3, "Enqueueing report: "

    iget-object v4, p0, Lcom/aliyun/emas/apm/crash/r0;->f:Ljava/util/concurrent/BlockingQueue;

    .line 4
    monitor-enter v4

    .line 5
    :try_start_0
    new-instance v5, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-direct {v5}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/r0;->h:Lcom/aliyun/emas/apm/crash/m0;

    .line 7
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/m0;->b()V

    .line 8
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->c()Z

    move-result p2

    if-eqz p2, :cond_0

    .line 9
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 10
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/r0;->f:Ljava/util/concurrent/BlockingQueue;

    invoke-interface {v1}, Ljava/util/Collection;->size()I

    move-result v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/r0;->g:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 11
    new-instance v1, Lcom/aliyun/emas/apm/crash/r0$b;

    const/4 v2, 0x0

    invoke-direct {v1, p0, p1, v5, v2}, Lcom/aliyun/emas/apm/crash/r0$b;-><init>(Lcom/aliyun/emas/apm/crash/r0;Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;Lcom/aliyun/emas/apm/crash/r0$a;)V

    invoke-virtual {p2, v1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 15
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 16
    invoke-virtual {v5, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 18
    monitor-exit v4

    return-object v5

    .line 21
    :cond_0
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/r0;->b()I

    .line 22
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 23
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/r0;->h:Lcom/aliyun/emas/apm/crash/m0;

    .line 24
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/m0;->a()V

    .line 25
    invoke-virtual {v5, p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 26
    monitor-exit v4

    return-object v5

    .line 29
    :cond_1
    invoke-direct {p0, p1, v5}, Lcom/aliyun/emas/apm/crash/r0;->a(Lcom/aliyun/emas/apm/crash/q;Lcom/google/android/gms/tasks/TaskCompletionSource;)V

    .line 30
    monitor-exit v4

    return-object v5

    :catchall_0
    move-exception p1

    .line 31
    monitor-exit v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method
