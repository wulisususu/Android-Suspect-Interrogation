.class public Lcom/aliyun/emas/apm/crash/internal/persistence/a;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final e:Ljava/nio/charset/Charset;

.field private static final f:I

.field private static final g:Lcom/aliyun/emas/apm/crash/p;

.field private static final h:Ljava/util/Comparator;

.field private static final i:Ljava/io/FilenameFilter;


# instance fields
.field private final a:Ljava/util/concurrent/atomic/AtomicInteger;

.field private final b:Landroid/content/Context;

.field private final c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

.field private final d:Lcom/aliyun/emas/apm/crash/x0;


# direct methods
.method public static synthetic $r8$lambda$C4YpBMf9BAftY0f77YE7fjEPnlM(Ljava/io/File;Ljava/io/File;)I
    .locals 0

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;Ljava/io/File;)I

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$Dj3JVhWU79g0ysCiyahgQSPSVPg(Ljava/io/File;Ljava/lang/String;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$iFzcQPX-qd67KNLGfsJ29plFEFk(Ljava/io/File;Ljava/lang/String;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b(Ljava/io/File;Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$n2oTwR2rmaPc3d1DM9NRJHP6PgQ(Ljava/io/File;Ljava/io/File;)I
    .locals 0

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b(Ljava/io/File;Ljava/io/File;)I

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    const-string v0, "UTF-8"

    .line 1
    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->e:Ljava/nio/charset/Charset;

    const/16 v0, 0xf

    sput v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->f:I

    .line 18
    new-instance v0, Lcom/aliyun/emas/apm/crash/p;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/p;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 21
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda2;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda2;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->h:Ljava/util/Comparator;

    .line 24
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda3;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda3;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->i:Ljava/io/FilenameFilter;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/x0;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b:Landroid/content/Context;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->d:Lcom/aliyun/emas/apm/crash/x0;

    return-void
.end method

.method private static synthetic a(Ljava/io/File;Ljava/io/File;)I
    .locals 0

    .line 1
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private a(Ljava/lang/String;I)I
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 101
    new-instance v1, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda0;-><init>()V

    .line 102
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFiles(Ljava/lang/String;Ljava/io/FilenameFilter;)Ljava/util/List;

    move-result-object p1

    .line 104
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a$$ExternalSyntheticLambda1;-><init>()V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 105
    invoke-static {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/util/List;I)I

    move-result p1

    return p1
.end method

.method private static a(Ljava/util/List;I)I
    .locals 2

    .line 121
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    .line 122
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/File;

    if-gt v0, p1, :cond_0

    return v0

    .line 126
    :cond_0
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->c(Ljava/io/File;)Z

    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_1
    return v0
.end method

.method private static a(IZ)Ljava/lang/String;
    .locals 2

    .line 98
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v1, "%010d"

    invoke-static {v0, v1, p0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    if-eqz p1, :cond_0

    const-string p1, "_"

    goto :goto_0

    :cond_0
    const-string p1, ""

    .line 100
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "event"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static a(Ljava/io/File;)Ljava/lang/String;
    .locals 4

    const/16 v0, 0x2000

    new-array v0, v0, [B

    .line 112
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 113
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 115
    :goto_0
    :try_start_0
    invoke-virtual {v2, v0}, Ljava/io/FileInputStream;->read([B)I

    move-result p0

    if-lez p0, :cond_0

    const/4 v3, 0x0

    .line 116
    invoke-virtual {v1, v0, v3, p0}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 118
    :cond_0
    new-instance p0, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    sget-object v1, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->e:Ljava/nio/charset/Charset;

    invoke-direct {p0, v0, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 119
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V

    return-object p0

    :catchall_0
    move-exception p0

    .line 120
    :try_start_1
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v0

    invoke-virtual {p0, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p0
.end method

.method private a(Ljava/lang/String;)Ljava/util/SortedSet;
    .locals 5

    .line 47
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->d()Ljava/util/SortedSet;

    move-result-object v0

    if-eqz p1, :cond_0

    .line 49
    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 51
    :cond_0
    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result p1

    const/16 v1, 0x8

    if-gt p1, v1, :cond_1

    return-object v0

    .line 55
    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result p1

    if-le p1, v1, :cond_2

    .line 56
    invoke-interface {v0}, Ljava/util/SortedSet;->last()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    .line 57
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Removing session over cap: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 59
    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->deleteSessionFiles(Ljava/lang/String;)Z

    .line 60
    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private a()V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->d:Lcom/aliyun/emas/apm/crash/x0;

    .line 61
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/x0;->getSettingsSync()Lcom/aliyun/emas/apm/crash/v0;

    move-result-object v0

    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/v0;->a:Lcom/aliyun/emas/apm/crash/v0$b;

    iget v0, v0, Lcom/aliyun/emas/apm/crash/v0$b;->b:I

    .line 62
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c()Ljava/util/List;

    move-result-object v1

    .line 64
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-gt v2, v0, :cond_0

    return-void

    .line 70
    :cond_0
    invoke-interface {v1, v0, v2}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object v0

    .line 71
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/File;

    .line 72
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    goto :goto_0

    :cond_1
    return-void
.end method

.method private static a(Ljava/io/File;Ljava/lang/String;J)V
    .locals 3

    .line 106
    new-instance v0, Ljava/io/OutputStreamWriter;

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object v2, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->e:Ljava/nio/charset/Charset;

    invoke-direct {v0, v1, v2}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    .line 107
    :try_start_0
    invoke-virtual {v0, p1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 108
    invoke-virtual {p0, p2, p3}, Ljava/io/File;->setLastModified(J)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 109
    invoke-virtual {v0}, Ljava/io/OutputStreamWriter;->close()V

    return-void

    :catchall_0
    move-exception p0

    .line 110
    :try_start_1
    invoke-virtual {v0}, Ljava/io/OutputStreamWriter;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p0
.end method

.method private a(Ljava/io/File;Ljava/util/List;JJZLjava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/k0;Lcom/aliyun/emas/apm/crash/e0;)V
    .locals 4

    :try_start_0
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 75
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/p;->c(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object v1

    .line 76
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, p5, p6, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->withTime(JJ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p5

    .line 77
    invoke-virtual {p5, p3, p4, p7}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->withSessionEndFields(JZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p3

    .line 78
    invoke-virtual {p3, p8, p9}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->withUser(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p3

    const/4 p4, 0x0

    if-nez p10, :cond_0

    move-object p5, p4

    goto :goto_0

    .line 79
    :cond_0
    invoke-virtual {p10}, Lcom/aliyun/emas/apm/crash/k0;->b()Ljava/lang/String;

    move-result-object p5

    :goto_0
    if-nez p10, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p10}, Lcom/aliyun/emas/apm/crash/k0;->a()Ljava/lang/String;

    move-result-object p4

    :goto_1
    invoke-virtual {p3, p5, p4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->withNetwork(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p3

    .line 80
    invoke-virtual {p11}, Lcom/aliyun/emas/apm/crash/e0;->a()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p3, p4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->withLog(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p3

    .line 81
    invoke-virtual {p3, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->withEvents(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p2

    .line 83
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p3

    if-nez p3, :cond_2

    return-void

    :cond_2
    if-eqz p7, :cond_3

    iget-object p4, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 92
    invoke-virtual {p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getIdentifier()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p4, p3}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getPriorityReport(Ljava/lang/String;)Ljava/io/File;

    move-result-object p3

    goto :goto_2

    :cond_3
    iget-object p4, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 93
    invoke-virtual {p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getIdentifier()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p4, p3}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getReport(Ljava/lang/String;)Ljava/io/File;

    move-result-object p3

    .line 94
    :goto_2
    invoke-virtual {v0, p2}, Lcom/aliyun/emas/apm/crash/p;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p3, p2}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    move-exception p2

    .line 96
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p3

    new-instance p4, Ljava/lang/StringBuilder;

    const-string p5, "Could not synthesize final report file for "

    invoke-direct {p4, p5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_3
    return-void
.end method

.method private a(Ljava/util/List;)V
    .locals 1

    .line 36
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    .line 38
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    goto :goto_0

    :cond_0
    return-void
.end method

.method private static a(Ljava/io/File;Ljava/lang/String;)Z
    .locals 0

    const-string p0, "event"

    .line 97
    invoke-virtual {p1, p0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-string p0, "_"

    invoke-virtual {p1, p0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static b(Ljava/io/File;Ljava/io/File;)I
    .locals 0

    .line 49
    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 50
    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 51
    invoke-virtual {p0, p1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private b(Ljava/lang/String;JJLcom/aliyun/emas/apm/crash/c1;)V
    .locals 16

    move-object/from16 v13, p0

    move-object/from16 v1, p1

    iget-object v0, v13, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    sget-object v2, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->i:Ljava/io/FilenameFilter;

    .line 4
    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFiles(Ljava/lang/String;Ljava/io/FilenameFilter;)Ljava/util/List;

    move-result-object v0

    .line 7
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 8
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Session "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " has no events."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    return-void

    .line 12
    :cond_0
    invoke-static {v0}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 14
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 18
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    const/4 v4, 0x0

    const-wide/16 v5, -0x1

    move v8, v4

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v7, v0

    check-cast v7, Ljava/io/File;

    :try_start_0
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 20
    invoke-static {v7}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v0, v9}, Lcom/aliyun/emas/apm/crash/p;->a(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object v0

    .line 21
    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-nez v8, :cond_3

    .line 22
    invoke-virtual {v7}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->e(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_1

    :cond_2
    move v8, v4

    goto :goto_2

    :cond_3
    :goto_1
    const/4 v0, 0x1

    move v8, v0

    .line 23
    :goto_2
    invoke-virtual {v7}, Ljava/io/File;->lastModified()J

    move-result-wide v9

    cmp-long v0, v9, v5

    if-lez v0, :cond_1

    .line 24
    invoke-virtual {v7}, Ljava/io/File;->lastModified()J

    move-result-wide v5
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 27
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v9

    new-instance v10, Ljava/lang/StringBuilder;

    const-string v11, "Could not add event to report for "

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v9, v7, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 32
    :cond_4
    invoke-interface {v3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 33
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Could not parse event files for session "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    return-void

    .line 37
    :cond_5
    invoke-virtual/range {p6 .. p6}, Lcom/aliyun/emas/apm/crash/c1;->e()Lcom/aliyun/emas/apm/crash/b1;

    move-result-object v0

    const/4 v2, 0x0

    if-eqz v0, :cond_6

    .line 38
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/b1;->a()Ljava/lang/String;

    move-result-object v4

    move-object v9, v4

    goto :goto_3

    :cond_6
    move-object v9, v2

    :goto_3
    if-eqz v0, :cond_7

    .line 39
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/b1;->b()Ljava/lang/String;

    move-result-object v0

    move-object v10, v0

    goto :goto_4

    :cond_7
    move-object v10, v2

    .line 41
    :goto_4
    new-instance v11, Lcom/aliyun/emas/apm/crash/k0;

    invoke-direct {v11}, Lcom/aliyun/emas/apm/crash/k0;-><init>()V

    iget-object v0, v13, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b:Landroid/content/Context;

    .line 42
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/l0;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v11, v0}, Lcom/aliyun/emas/apm/crash/k0;->b(Ljava/lang/String;)V

    iget-object v0, v13, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b:Landroid/content/Context;

    .line 43
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/l0;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v11, v0}, Lcom/aliyun/emas/apm/crash/k0;->a(Ljava/lang/String;)V

    const-wide/16 v14, 0x0

    cmp-long v0, p4, v14

    if-lez v0, :cond_8

    move-wide/from16 v6, p4

    goto :goto_5

    :cond_8
    cmp-long v0, v5, v14

    if-lez v0, :cond_9

    move-wide v6, v5

    goto :goto_5

    :cond_9
    move-wide/from16 v6, p2

    :goto_5
    iget-object v0, v13, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v2, "report"

    .line 46
    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    .line 47
    new-instance v12, Lcom/aliyun/emas/apm/crash/e0;

    iget-object v0, v13, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v12, v0, v1}, Lcom/aliyun/emas/apm/crash/e0;-><init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Ljava/lang/String;)V

    move-object/from16 v1, p0

    move-wide/from16 v4, p2

    .line 48
    invoke-direct/range {v1 .. v12}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;Ljava/util/List;JJZLjava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/k0;Lcom/aliyun/emas/apm/crash/e0;)V

    return-void
.end method

.method private static synthetic b(Ljava/io/File;Ljava/lang/String;)Z
    .locals 0

    const-string p0, "event"

    .line 1
    invoke-virtual {p1, p0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private static c(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    sget v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->f:I

    const/4 v1, 0x0

    .line 9
    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private c()Ljava/util/List;
    .locals 3

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 2
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getPriorityReports()Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    sget-object v1, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->h:Ljava/util/Comparator;

    .line 3
    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 5
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getReports()Ljava/util/List;

    move-result-object v2

    .line 6
    invoke-static {v2, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 8
    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-object v0
.end method

.method private static c(Ljava/io/File;Ljava/lang/String;)V
    .locals 2

    .line 10
    new-instance v0, Ljava/io/OutputStreamWriter;

    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    sget-object p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->e:Ljava/nio/charset/Charset;

    invoke-direct {v0, v1, p0}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    .line 11
    :try_start_0
    invoke-virtual {v0, p1}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 12
    invoke-virtual {v0}, Ljava/io/OutputStreamWriter;->close()V

    return-void

    :catchall_0
    move-exception p0

    .line 13
    :try_start_1
    invoke-virtual {v0}, Ljava/io/OutputStreamWriter;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p0
.end method

.method private static e(Ljava/lang/String;)Z
    .locals 1

    const-string v0, "event"

    .line 3
    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "_"

    invoke-virtual {p0, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Ljava/lang/String;Z)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->d:Lcom/aliyun/emas/apm/crash/x0;

    .line 27
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/x0;->getSettingsSync()Lcom/aliyun/emas/apm/crash/v0;

    move-result-object v0

    iget-object v0, v0, Lcom/aliyun/emas/apm/crash/v0;->a:Lcom/aliyun/emas/apm/crash/v0$b;

    iget v0, v0, Lcom/aliyun/emas/apm/crash/v0$b;->a:I

    sget-object v1, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 28
    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/p;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;)Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 29
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v1

    invoke-static {v1, p3}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(IZ)Ljava/lang/String;

    move-result-object p3

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 31
    invoke-virtual {v1, p2, p3}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p3

    invoke-static {p3, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 33
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p3

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Could not persist event for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3, v1, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 35
    :goto_0
    invoke-direct {p0, p2, v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/lang/String;I)I

    return-void
.end method

.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)V
    .locals 6

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->getPayload()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v0

    if-nez v0, :cond_0

    .line 4
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "Could not get session for report"

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    return-void

    .line 8
    :cond_0
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getIdentifier()Ljava/lang/String;

    move-result-object v1

    :try_start_0
    sget-object v2, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 10
    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/p;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)Ljava/lang/String;

    move-result-object p1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v4, "report"

    .line 11
    invoke-virtual {v3, v1, v4}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v3

    invoke-static {v3, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c(Ljava/io/File;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v3, "start-time"

    .line 13
    invoke-virtual {p1, v1, v3}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    const-string v3, ""

    .line 15
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getStartedAt()J

    move-result-wide v4

    .line 16
    invoke-static {p1, v3, v4, v5}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;Ljava/lang/String;J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b:Landroid/content/Context;

    .line 21
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/n0;->b(Landroid/content/Context;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v3, "current-process"

    .line 23
    invoke-virtual {v0, v1, v3}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/p;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 26
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Could not persist report for session "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public a(Ljava/lang/String;JJLcom/aliyun/emas/apm/crash/c1;)V
    .locals 8

    .line 39
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/lang/String;)Ljava/util/SortedSet;

    move-result-object p1

    .line 40
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 41
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Finalizing report for session "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    move-object v1, p0

    move-object v2, v0

    move-wide v3, p2

    move-wide v5, p4

    move-object v7, p6

    .line 42
    invoke-direct/range {v1 .. v7}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b(Ljava/lang/String;JJLcom/aliyun/emas/apm/crash/c1;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 44
    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->deleteSessionFiles(Ljava/lang/String;)Z

    goto :goto_0

    .line 46
    :cond_0
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a()V

    return-void
.end method

.method public b(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "current-process"

    .line 52
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    .line 53
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 58
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/p;->b(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object p1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    return-object v1
.end method

.method public b()V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 2
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getReports()Ljava/util/List;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/util/List;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 3
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getPriorityReports()Ljava/util/List;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/util/List;)V

    return-void
.end method

.method public d(Ljava/lang/String;)J
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "start-time"

    .line 3
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    .line 4
    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v0

    return-wide v0
.end method

.method public d()Ljava/util/SortedSet;
    .locals 2

    .line 1
    new-instance v0, Ljava/util/TreeSet;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getAllOpenSessionIds()Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/TreeSet;-><init>(Ljava/util/Collection;)V

    invoke-virtual {v0}, Ljava/util/TreeSet;->descendingSet()Ljava/util/NavigableSet;

    move-result-object v0

    return-object v0
.end method

.method public e()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getReports()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 2
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getPriorityReports()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public f()Ljava/util/List;
    .locals 7

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->c()Ljava/util/List;

    move-result-object v0

    .line 2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 3
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/io/File;

    :try_start_0
    sget-object v3, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->g:Lcom/aliyun/emas/apm/crash/p;

    .line 5
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/io/File;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/aliyun/emas/apm/crash/p;->c(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object v3

    .line 7
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v2}, Lcom/aliyun/emas/apm/crash/q;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;Ljava/lang/String;Ljava/io/File;)Lcom/aliyun/emas/apm/crash/q;

    move-result-object v3

    .line 8
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    .line 11
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "Could not load report file "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "; deleting"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 12
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto :goto_0

    :cond_0
    return-object v1
.end method
