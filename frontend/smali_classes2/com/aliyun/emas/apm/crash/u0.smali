.class public Lcom/aliyun/emas/apm/crash/u0;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/o;

.field private final b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

.field private final c:Lcom/aliyun/emas/apm/crash/v;

.field private final d:Lcom/aliyun/emas/apm/crash/e0;

.field private final e:Lcom/aliyun/emas/apm/crash/c1;

.field private final f:Lcom/aliyun/emas/apm/crash/b0;


# direct methods
.method public static synthetic $r8$lambda$sqgaPyDYFsiFXJxpAIRNv8_WrRQ(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;)I
    .locals 0

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/u0;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;)I

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$ztNpGdYFrD9KvLzqxYPXMwdURKE(Lcom/aliyun/emas/apm/crash/u0;Lcom/google/android/gms/tasks/Task;)Z
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/u0;->a(Lcom/google/android/gms/tasks/Task;)Z

    move-result p0

    return p0
.end method

.method constructor <init>(Lcom/aliyun/emas/apm/crash/o;Lcom/aliyun/emas/apm/crash/internal/persistence/a;Lcom/aliyun/emas/apm/crash/v;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/c1;Lcom/aliyun/emas/apm/crash/b0;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/u0;->a:Lcom/aliyun/emas/apm/crash/o;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/u0;->c:Lcom/aliyun/emas/apm/crash/v;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/u0;->d:Lcom/aliyun/emas/apm/crash/e0;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/u0;->e:Lcom/aliyun/emas/apm/crash/c1;

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/u0;->f:Lcom/aliyun/emas/apm/crash/b0;

    return-void
.end method

.method private static synthetic a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;)I
    .locals 0

    .line 146
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;->getKey()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;->getKey()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private a(Ljava/lang/String;Ljava/util/List;)Landroid/app/ApplicationExitInfo;
    .locals 5

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 180
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->d(Ljava/lang/String;)J

    move-result-wide v0

    .line 184
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    const/4 v2, 0x0

    if-eqz p2, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Landroid/app/ApplicationExitInfo;

    .line 186
    invoke-virtual {p2}, Landroid/app/ApplicationExitInfo;->getTimestamp()J

    move-result-wide v3

    cmp-long v3, v3, v0

    if-gez v3, :cond_0

    return-object v2

    .line 192
    :cond_0
    invoke-virtual {p2}, Landroid/app/ApplicationExitInfo;->getReason()I

    move-result v2

    const/4 v3, 0x6

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    return-object p2

    :cond_2
    return-object v2
.end method

.method private static a(Landroid/app/ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;
    .locals 4

    .line 147
    :try_start_0
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getTraceInputStream()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 149
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 152
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Could not get input trace in application exit info: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 155
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " Error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 156
    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    :cond_0
    const/4 v0, 0x0

    .line 163
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 164
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getImportance()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 165
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getProcessName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setProcessName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 166
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getReason()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setReasonCode(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 167
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getTimestamp()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 168
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getPid()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setPid(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 169
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getPss()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setPss(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 170
    invoke-virtual {p0}, Landroid/app/ApplicationExitInfo;->getRss()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setRss(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object p0

    .line 171
    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setTraceFile(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object p0

    .line 172
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object p0

    return-object p0
.end method

.method private a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->e:Lcom/aliyun/emas/apm/crash/c1;

    .line 78
    invoke-direct {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/u0;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->e:Lcom/aliyun/emas/apm/crash/c1;

    .line 80
    invoke-direct {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/u0;->c(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->e:Lcom/aliyun/emas/apm/crash/c1;

    .line 82
    invoke-direct {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/u0;->b(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    return-object p1
.end method

.method private a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 3

    .line 83
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 86
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/c1;->a()Ljava/util/Map;

    move-result-object v1

    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/util/Map;)Ljava/util/List;

    move-result-object v1

    .line 88
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/c1;->b()Ljava/util/Map;

    move-result-object p2

    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/util/Map;)Ljava/util/List;

    move-result-object p2

    .line 90
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 92
    :cond_0
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 93
    invoke-virtual {p1, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setCustomAttributes(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 94
    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setInternalKeys(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 95
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    .line 96
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    .line 103
    :cond_1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    return-object p1
.end method

.method public static a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/c1;Lcom/aliyun/emas/apm/crash/y0;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/ApmOptions;Lcom/aliyun/emas/apm/crash/m0;)Lcom/aliyun/emas/apm/crash/u0;
    .locals 10

    move-object v6, p0

    move-object/from16 v7, p7

    .line 1
    new-instance v8, Lcom/aliyun/emas/apm/crash/o;

    move-object v0, v8

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    move-object/from16 v4, p6

    move-object/from16 v5, p7

    invoke-direct/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/o;-><init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/crash/y0;Lcom/aliyun/emas/apm/crash/x0;)V

    .line 4
    new-instance v2, Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    move-object v0, p2

    invoke-direct {v2, p0, p2, v7}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;-><init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/x0;)V

    move-object v9, p1

    move-object/from16 v0, p8

    move-object/from16 v1, p9

    .line 7
    invoke-static {p0, v7, v1, p1, v0}, Lcom/aliyun/emas/apm/crash/v;->a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/crash/m0;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/ApmOptions;)Lcom/aliyun/emas/apm/crash/v;

    move-result-object v3

    .line 8
    new-instance v7, Lcom/aliyun/emas/apm/crash/u0;

    move-object v0, v7

    move-object v1, v8

    move-object v4, p4

    move-object v5, p5

    move-object v6, p1

    invoke-direct/range {v0 .. v6}, Lcom/aliyun/emas/apm/crash/u0;-><init>(Lcom/aliyun/emas/apm/crash/o;Lcom/aliyun/emas/apm/crash/internal/persistence/a;Lcom/aliyun/emas/apm/crash/v;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/c1;Lcom/aliyun/emas/apm/crash/b0;)V

    return-object v7
.end method

.method public static a(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 4

    .line 173
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v1, 0x2000

    new-array v1, v1, [B

    .line 176
    :goto_0
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_0

    const/4 v3, 0x0

    .line 177
    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 179
    :cond_0
    sget-object p0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static a(Ljava/util/Map;)Ljava/util/List;
    .locals 4

    .line 131
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 132
    invoke-interface {p0}, Ljava/util/Map;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->ensureCapacity(I)V

    .line 133
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 135
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;->setKey(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v2, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;->setValue(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;

    move-result-object v1

    .line 136
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 141
    :cond_0
    new-instance p0, Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda0;

    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v0, p0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 145
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method private a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;Ljava/lang/String;JZ)V
    .locals 11

    move-object v0, p0

    const-string v1, "java"

    move-object v5, p4

    .line 104
    invoke-virtual {p4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/u0;->a:Lcom/aliyun/emas/apm/crash/o;

    const/4 v8, 0x4

    const/16 v9, 0x8

    move-object v3, p1

    move-object v4, p2

    move-wide/from16 v6, p5

    move/from16 v10, p7

    .line 107
    invoke-virtual/range {v2 .. v10}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;JIIZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object v2

    iget-object v3, v0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 116
    invoke-direct {p0, v2}, Lcom/aliyun/emas/apm/crash/u0;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object v2

    move-object v4, p3

    invoke-virtual {v3, v2, p3, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Ljava/lang/String;Z)V

    return-void
.end method

.method private a(Lcom/google/android/gms/tasks/Task;)Z
    .locals 3

    .line 117
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->isSuccessful()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 118
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getResult()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/crash/q;

    .line 119
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Crashlytics report successfully enqueued to DataTransport: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 120
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 121
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/q;->b()Ljava/io/File;

    move-result-object p1

    .line 122
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 123
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Deleted report file: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 125
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Crashlytics could not delete report file: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    :goto_0
    const/4 p1, 0x1

    return p1

    .line 129
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    .line 130
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->getException()Ljava/lang/Exception;

    move-result-object p1

    const-string v1, "Crashlytics report could not be enqueued to DataTransport"

    invoke-virtual {v0, v1, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 p1, 0x0

    return p1
.end method

.method private b(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 1

    .line 4
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/c1;->d()Ljava/util/List;

    move-result-object p2

    .line 6
    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p1

    .line 10
    :cond_0
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    .line 12
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;

    move-result-object v0

    .line 13
    invoke-virtual {v0, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;->setRolloutAssignments(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;

    move-result-object p2

    .line 14
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    move-result-object p2

    .line 15
    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setRollouts(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    .line 19
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    return-object p1
.end method

.method private c(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 4

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 4
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/c1;->e()Lcom/aliyun/emas/apm/crash/b1;

    move-result-object v1

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    if-eqz v1, :cond_1

    .line 6
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b1;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b1;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 7
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object v2

    .line 8
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b1;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->setId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object v2

    .line 9
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b1;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->setNick(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object v1

    .line 10
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v1

    .line 11
    invoke-virtual {p1, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    .line 17
    :cond_1
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/c1;->c()Lcom/aliyun/emas/apm/crash/k0;

    move-result-object p2

    if-eqz p2, :cond_3

    .line 18
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/k0;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/k0;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 19
    :cond_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object v1

    .line 20
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/k0;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->setCarrier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object v1

    .line 21
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/k0;->a()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->setAccess(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object p2

    .line 22
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object p2

    .line 23
    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    .line 29
    :cond_3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public a(Ljava/util/concurrent/Executor;)Lcom/google/android/gms/tasks/Task;
    .locals 1

    const/4 v0, 0x0

    .line 60
    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/util/concurrent/Executor;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public a(Ljava/util/concurrent/Executor;Ljava/lang/String;)Lcom/google/android/gms/tasks/Task;
    .locals 5

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 62
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->f()Ljava/util/List;

    move-result-object v0

    .line 63
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 64
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/crash/q;

    if-eqz p2, :cond_1

    .line 65
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/q;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    :cond_1
    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/u0;->c:Lcom/aliyun/emas/apm/crash/v;

    if-eqz p2, :cond_2

    const/4 v4, 0x1

    goto :goto_1

    :cond_2
    const/4 v4, 0x0

    .line 68
    :goto_1
    invoke-virtual {v3, v2, v4}, Lcom/aliyun/emas/apm/crash/v;->a(Lcom/aliyun/emas/apm/crash/q;Z)Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    new-instance v3, Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda1;

    invoke-direct {v3, p0}, Lcom/aliyun/emas/apm/crash/u0$$ExternalSyntheticLambda1;-><init>(Lcom/aliyun/emas/apm/crash/u0;)V

    .line 69
    invoke-virtual {v2, p1, v3}, Lcom/google/android/gms/tasks/Task;->continueWith(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object v2

    .line 70
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 76
    :cond_3
    invoke-static {v1}, Lcom/google/android/gms/tasks/Tasks;->whenAll(Ljava/util/Collection;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public a(JJLjava/lang/String;)V
    .locals 7

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    iget-object v6, p0, Lcom/aliyun/emas/apm/crash/u0;->e:Lcom/aliyun/emas/apm/crash/c1;

    move-object v1, p5

    move-wide v2, p1

    move-wide v4, p3

    .line 58
    invoke-virtual/range {v0 .. v6}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Ljava/lang/String;JJLcom/aliyun/emas/apm/crash/c1;)V

    return-void
.end method

.method public a(JLjava/lang/String;Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/c1;)V
    .locals 7

    .line 37
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 38
    invoke-interface {p4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p4

    :cond_0
    :goto_0
    invoke-interface {p4}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/crash/i0;

    .line 39
    invoke-interface {v1}, Lcom/aliyun/emas/apm/crash/i0;->a()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 41
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object p4, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 45
    invoke-virtual {p4, p3}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object v6

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/u0;->a:Lcom/aliyun/emas/apm/crash/o;

    .line 48
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;

    move-result-object p4

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p4, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;->setFiles(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;

    move-result-object p4

    invoke-virtual {p4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    move-result-object v4

    move-wide v2, p1

    move-object v5, p5

    invoke-virtual/range {v1 .. v6}, Lcom/aliyun/emas/apm/crash/o;->a(JLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    .line 51
    invoke-direct {p0, p1, p6}, Lcom/aliyun/emas/apm/crash/u0;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    .line 54
    invoke-direct {p0, p1, p6}, Lcom/aliyun/emas/apm/crash/u0;->c(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    .line 56
    invoke-direct {p0, p1, p6}, Lcom/aliyun/emas/apm/crash/u0;->b(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    const/4 p4, 0x1

    .line 57
    invoke-virtual {p2, p1, p3, p4}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Ljava/lang/String;Z)V

    return-void
.end method

.method public a(Ljava/lang/String;J)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->a:Lcom/aliyun/emas/apm/crash/o;

    .line 10
    invoke-virtual {v0, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/String;J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 12
    invoke-virtual {p2, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/c1;)V
    .locals 2

    .line 15
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/lang/String;Ljava/util/List;)Landroid/app/ApplicationExitInfo;

    move-result-object p2

    if-nez p2, :cond_0

    .line 18
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    new-instance p3, Ljava/lang/StringBuilder;

    const-string p4, "No relevant ApplicationExitInfo occurred during session: "

    invoke-direct {p3, p4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p3, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 22
    invoke-virtual {p3, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object p3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->a:Lcom/aliyun/emas/apm/crash/o;

    .line 25
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/u0;->a(Landroid/app/ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object p2

    invoke-virtual {v0, p2, p3}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p2

    .line 27
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Persisting anr for session "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 30
    invoke-direct {p0, p2, p4}, Lcom/aliyun/emas/apm/crash/u0;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p2

    .line 33
    invoke-direct {p0, p2, p4}, Lcom/aliyun/emas/apm/crash/u0;->c(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p2

    .line 35
    invoke-direct {p0, p2, p4}, Lcom/aliyun/emas/apm/crash/u0;->b(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p2

    iget-object p3, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    const/4 p4, 0x1

    .line 36
    invoke-virtual {p3, p2, p1, p4}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Ljava/lang/String;Z)V

    return-void
.end method

.method public a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;J)V
    .locals 10

    .line 13
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Persisting fatal event for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    const-string v6, "java"

    const/4 v9, 0x1

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-wide v7, p4

    .line 14
    invoke-direct/range {v2 .. v9}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;Ljava/lang/String;JZ)V

    return-void
.end method

.method public a()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 59
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->e()Z

    move-result v0

    return v0
.end method

.method public b()Ljava/util/SortedSet;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 3
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->d()Ljava/util/SortedSet;

    move-result-object v0

    return-object v0
.end method

.method public b(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;J)V
    .locals 10

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Persisting non-fatal event for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    const-string v6, "error"

    const/4 v9, 0x0

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-wide v7, p4

    .line 2
    invoke-direct/range {v2 .. v9}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;Ljava/lang/String;JZ)V

    return-void
.end method

.method public c()V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/u0;->b:Lcom/aliyun/emas/apm/crash/internal/persistence/a;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/persistence/a;->b()V

    return-void
.end method
