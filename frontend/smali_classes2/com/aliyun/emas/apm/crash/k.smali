.class Lcom/aliyun/emas/apm/crash/k;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Landroid/content/Context;

.field private final b:Lcom/aliyun/emas/apm/crash/u;

.field private final c:Lcom/aliyun/emas/apm/crash/m;

.field private final d:Lcom/aliyun/emas/apm/crash/c1;

.field private final e:Lcom/aliyun/emas/apm/crash/j;

.field private final f:Lcom/aliyun/emas/apm/crash/b0;

.field private final g:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

.field private final h:Lcom/aliyun/emas/apm/crash/a;

.field private final i:Lcom/aliyun/emas/apm/crash/e0;

.field private final j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

.field private final k:Lcom/aliyun/emas/apm/crash/u0;

.field private l:Lcom/aliyun/emas/apm/crash/s;

.field private m:Lcom/aliyun/emas/apm/crash/x0;

.field private n:Lcom/aliyun/emas/apm/settings/SettingProvider;

.field final o:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field final p:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field final q:Lcom/google/android/gms/tasks/TaskCompletionSource;

.field final r:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/j;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/u;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/m;Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/crash/c1;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/u0;Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->m:Lcom/aliyun/emas/apm/crash/x0;

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->n:Lcom/aliyun/emas/apm/settings/SettingProvider;

    .line 7
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->o:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 11
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->p:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 16
    new-instance v0, Lcom/google/android/gms/tasks/TaskCompletionSource;

    invoke-direct {v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->q:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 19
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->r:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/k;->f:Lcom/aliyun/emas/apm/crash/b0;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/k;->b:Lcom/aliyun/emas/apm/crash/u;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/k;->g:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/k;->c:Lcom/aliyun/emas/apm/crash/m;

    iput-object p7, p0, Lcom/aliyun/emas/apm/crash/k;->h:Lcom/aliyun/emas/apm/crash/a;

    iput-object p8, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    iput-object p9, p0, Lcom/aliyun/emas/apm/crash/k;->i:Lcom/aliyun/emas/apm/crash/e0;

    iput-object p11, p0, Lcom/aliyun/emas/apm/crash/k;->j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    iput-object p10, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/k;)Ljava/lang/String;
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/k;->b()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static a(Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;)Ljava/util/List;
    .locals 5

    .line 182
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 183
    new-instance v1, Lcom/aliyun/emas/apm/crash/z;

    .line 185
    invoke-interface {p0}, Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;->getMetadataFile()Ljava/io/File;

    move-result-object v2

    const-string v3, "crash_meta_file"

    const-string v4, "metadata"

    invoke-direct {v1, v3, v4, v2}, Lcom/aliyun/emas/apm/crash/z;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    .line 186
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 189
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/k;->b(Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;)Lcom/aliyun/emas/apm/crash/i0;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 190
    new-instance v1, Lcom/aliyun/emas/apm/crash/z;

    invoke-interface {p0}, Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;->getStatusFile()Ljava/io/File;

    move-result-object v2

    const-string v3, "crash_status_info"

    const-string v4, "status"

    invoke-direct {v1, v3, v4, v2}, Lcom/aliyun/emas/apm/crash/z;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 191
    new-instance v1, Lcom/aliyun/emas/apm/crash/z;

    invoke-interface {p0}, Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;->getLogcatFile()Ljava/io/File;

    move-result-object p0

    const-string v2, "crash_logcat"

    const-string v3, "logcat"

    invoke-direct {v1, v2, v3, p0}, Lcom/aliyun/emas/apm/crash/z;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object v0
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/String;Ljava/lang/Boolean;)V
    .locals 0

    .line 2
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;Ljava/lang/Boolean;)V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/Boolean;)V
    .locals 5

    .line 123
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 125
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Opening a new session with ID "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k;->j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    .line 127
    invoke-interface {v2, p1}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->prepareNativeSession(Ljava/lang/String;)V

    .line 133
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    if-eqz p2, :cond_0

    if-eqz p1, :cond_0

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k;->a:Landroid/content/Context;

    .line 134
    invoke-virtual {p2, v2, p1}, Lcom/aliyun/emas/apm/crash/c1;->a(Landroid/content/Context;Ljava/lang/String;)V

    :cond_0
    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->i:Lcom/aliyun/emas/apm/crash/e0;

    .line 137
    invoke-virtual {p2, p1}, Lcom/aliyun/emas/apm/crash/e0;->b(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    .line 138
    invoke-virtual {p2, p1, v0, v1}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/lang/String;J)V

    return-void
.end method

.method private a(ZLcom/aliyun/emas/apm/crash/x0;)V
    .locals 6

    .line 140
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    .line 141
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/u0;->b()Ljava/util/SortedSet;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 143
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-gt v1, p1, :cond_0

    .line 144
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string p2, "No open sessions to be closed."

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    return-void

    .line 148
    :cond_0
    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 150
    invoke-interface {p2}, Lcom/aliyun/emas/apm/crash/x0;->getSettingsSync()Lcom/aliyun/emas/apm/crash/v0;

    move-result-object p2

    iget-object p2, p2, Lcom/aliyun/emas/apm/crash/v0;->b:Lcom/aliyun/emas/apm/crash/v0$a;

    iget-boolean p2, p2, Lcom/aliyun/emas/apm/crash/v0$a;->b:Z

    if-eqz p2, :cond_1

    .line 151
    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/k;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 153
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v2, "ANR feature disabled."

    invoke-virtual {p2, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    :goto_0
    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    .line 156
    invoke-interface {p2, v1}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->hasCrashDataForSession(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    .line 159
    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/k;->e(Ljava/lang/String;)V

    :cond_2
    if-eqz p1, :cond_3

    const/4 p1, 0x0

    .line 164
    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    goto :goto_1

    :cond_3
    const/4 p1, 0x0

    :goto_1
    move-object v5, p1

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/k;->c:Lcom/aliyun/emas/apm/crash/m;

    .line 168
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/m;->c()Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/k;->c:Lcom/aliyun/emas/apm/crash/m;

    .line 169
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/m;->b()Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide p1

    goto :goto_2

    :cond_4
    const-wide/16 p1, -0x1

    :goto_2
    move-wide v3, p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    .line 172
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/u0;->a(JJLjava/lang/String;)V

    return-void
.end method

.method private static a(Ljava/lang/String;Ljava/io/File;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Z
    .locals 3

    if-eqz p1, :cond_0

    .line 173
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 174
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "No minidump data found for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    :cond_1
    if-nez p2, :cond_2

    .line 178
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "No Tombstones data found for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->i(Ljava/lang/String;)V

    :cond_2
    if-eqz p1, :cond_3

    .line 181
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p0

    if-nez p0, :cond_4

    :cond_3
    if-nez p2, :cond_4

    const/4 p0, 0x1

    goto :goto_0

    :cond_4
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static b(Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;)Lcom/aliyun/emas/apm/crash/i0;
    .locals 4

    .line 27
    invoke-interface {p0}, Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;->getMinidumpFile()Ljava/io/File;

    move-result-object p0

    const-string v0, "minidump"

    const-string v1, "minidump_file"

    if-eqz p0, :cond_1

    .line 29
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 31
    :cond_0
    new-instance v2, Lcom/aliyun/emas/apm/crash/z;

    invoke-direct {v2, v1, v0, p0}, Lcom/aliyun/emas/apm/crash/z;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    goto :goto_1

    .line 32
    :cond_1
    :goto_0
    new-instance v2, Lcom/aliyun/emas/apm/crash/g;

    const/4 p0, 0x1

    new-array p0, p0, [B

    const/4 v3, 0x0

    aput-byte v3, p0, v3

    invoke-direct {v2, v1, v0, p0}, Lcom/aliyun/emas/apm/crash/g;-><init>(Ljava/lang/String;Ljava/lang/String;[B)V

    :goto_1
    return-object v2
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/m;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/k;->c:Lcom/aliyun/emas/apm/crash/m;

    return-object p0
.end method

.method private b()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    .line 9
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/u0;->b()Ljava/util/SortedSet;

    move-result-object v0

    .line 10
    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-interface {v0}, Ljava/util/SortedSet;->first()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method static synthetic c(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u0;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    return-object p0
.end method

.method static synthetic d(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/k;->b:Lcom/aliyun/emas/apm/crash/u;

    return-object p0
.end method

.method private d()Lcom/google/android/gms/tasks/Task;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->b:Lcom/aliyun/emas/apm/crash/u;

    .line 2
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/u;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Automatic data collection is enabled. Allowing upload."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->o:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 4
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    .line 5
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0

    .line 8
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Automatic data collection is disabled."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 9
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Notifying that unsent reports are available."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->o:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 10
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->b:Lcom/aliyun/emas/apm/crash/u;

    .line 18
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/u;->c()Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    new-instance v1, Lcom/aliyun/emas/apm/crash/k$c;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/crash/k$c;-><init>(Lcom/aliyun/emas/apm/crash/k;)V

    .line 19
    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    .line 28
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    const-string v2, "Waiting for send/deleteUnsentReports to be called."

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k;->p:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 30
    invoke-virtual {v1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/d1;->a(Lcom/google/android/gms/tasks/Task;Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    return-object v0
.end method

.method private d(Ljava/lang/String;)V
    .locals 4

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->a:Landroid/content/Context;

    const-string v1, "activity"

    .line 33
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 36
    invoke-virtual {v0, v1, v2, v2}, Landroid/app/ActivityManager;->getHistoricalProcessExitReasons(Ljava/lang/String;II)Ljava/util/List;

    move-result-object v0

    .line 40
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-eqz v1, :cond_0

    .line 41
    new-instance v1, Lcom/aliyun/emas/apm/crash/e0;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k;->g:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v1, v2, p1}, Lcom/aliyun/emas/apm/crash/e0;-><init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k;->g:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 43
    invoke-static {p1, v2, v3}, Lcom/aliyun/emas/apm/crash/c1;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/j;)Lcom/aliyun/emas/apm/crash/c1;

    move-result-object v2

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    .line 44
    invoke-virtual {v3, p1, v0, v1, v2}, Lcom/aliyun/emas/apm/crash/u0;->a(Ljava/lang/String;Ljava/util/List;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/c1;)V

    goto :goto_0

    .line 47
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "No ApplicationExitInfo available. Session: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    goto :goto_0

    .line 50
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ANR feature enabled, but device is API "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 51
    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method static synthetic e(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/j;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    return-object p0
.end method

.method private e(Ljava/lang/String;)V
    .locals 9

    .line 2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "write native event for session "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    .line 4
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->getSessionFileProvider(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;

    move-result-object v0

    .line 5
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;->getMinidumpFile()Ljava/io/File;

    move-result-object v1

    .line 7
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;->getApplicationExitInto()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object v7

    .line 9
    invoke-static {p1, v1, v7}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;Ljava/io/File;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 10
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "No native core present"

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    return-void

    .line 15
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k;->g:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 17
    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getNativeSessionDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 19
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_1

    .line 20
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "Couldn\'t create directory to store native session files, aborting."

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    return-void

    .line 24
    :cond_1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/crash/internal/NativeSessionFileProvider;)Ljava/util/List;

    move-result-object v6

    .line 25
    invoke-static {v1, v6}, Lcom/aliyun/emas/apm/crash/j0;->a(Ljava/io/File;Ljava/util/List;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->g:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 28
    invoke-static {p1, v0, v1}, Lcom/aliyun/emas/apm/crash/c1;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/j;)Lcom/aliyun/emas/apm/crash/c1;

    move-result-object v8

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    move-object v5, p1

    .line 30
    invoke-virtual/range {v2 .. v8}, Lcom/aliyun/emas/apm/crash/u0;->a(JLjava/lang/String;Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/c1;)V

    return-void
.end method

.method static synthetic f(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/e0;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/k;->i:Lcom/aliyun/emas/apm/crash/e0;

    return-object p0
.end method


# virtual methods
.method a(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->k:Lcom/aliyun/emas/apm/crash/u0;

    .line 101
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/u0;->a()Z

    move-result v0

    if-nez v0, :cond_0

    .line 103
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "No crash reports are available to be sent."

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/k;->o:Lcom/google/android/gms/tasks/TaskCompletionSource;

    .line 104
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {p1, v0}, Lcom/google/android/gms/tasks/TaskCompletionSource;->trySetResult(Ljava/lang/Object;)Z

    const/4 p1, 0x0

    .line 105
    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1

    .line 107
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Crash reports are available to be sent."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    .line 109
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/k;->d()Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    new-instance v1, Lcom/aliyun/emas/apm/crash/k$d;

    invoke-direct {v1, p0, p1}, Lcom/aliyun/emas/apm/crash/k$d;-><init>(Lcom/aliyun/emas/apm/crash/k;Lcom/google/android/gms/tasks/Task;)V

    .line 110
    invoke-virtual {v0, v1}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method a(JLjava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 111
    new-instance v1, Lcom/aliyun/emas/apm/crash/k$e;

    invoke-direct {v1, p0, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/k$e;-><init>(Lcom/aliyun/emas/apm/crash/k;JLjava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    return-void
.end method

.method a(Lcom/aliyun/emas/apm/crash/x0;)V
    .locals 1

    const/4 v0, 0x0

    .line 139
    invoke-direct {p0, v0, p1}, Lcom/aliyun/emas/apm/crash/k;->a(ZLcom/aliyun/emas/apm/crash/x0;)V

    return-void
.end method

.method a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 6

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    .line 24
    invoke-virtual/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;Z)V

    return-void
.end method

.method declared-synchronized a(Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread;Ljava/lang/Throwable;Z)V
    .locals 13

    move-object v10, p0

    const-string v0, "Handling uncaught exception \""

    monitor-enter p0

    .line 25
    :try_start_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-object/from16 v0, p4

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" from thread "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 26
    invoke-virtual/range {p3 .. p3}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 30
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    iget-object v11, v10, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 32
    new-instance v12, Lcom/aliyun/emas/apm/crash/k$b;

    move-object v1, v12

    move-object v2, p0

    move-object/from16 v3, p4

    move-object/from16 v4, p3

    move-object v7, p2

    move/from16 v8, p5

    move-object v9, p1

    invoke-direct/range {v1 .. v9}, Lcom/aliyun/emas/apm/crash/k$b;-><init>(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/Throwable;Ljava/lang/Thread;JLcom/aliyun/emas/apm/crash/x0;ZLcom/aliyun/emas/apm/settings/SettingProvider;)V

    .line 33
    invoke-virtual {v11, v12}, Lcom/aliyun/emas/apm/crash/j;->c(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez p5, :cond_0

    .line 85
    :try_start_1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/d1;->a(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/util/concurrent/TimeoutException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    move-object v1, v0

    .line 90
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v2, "Error handling uncaught exception"

    invoke-virtual {v0, v2, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 91
    :catch_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Cannot send reports. Timed out while fetching settings."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_0
    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method a(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 122
    new-instance v1, Lcom/aliyun/emas/apm/crash/k$g;

    invoke-direct {v1, p0, p1}, Lcom/aliyun/emas/apm/crash/k$g;-><init>(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    return-void
.end method

.method a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 115
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/c1;->a(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->a:Landroid/content/Context;

    if-eqz p2, :cond_1

    .line 117
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/i;->g(Landroid/content/Context;)Z

    move-result p2

    if-nez p2, :cond_0

    goto :goto_0

    .line 118
    :cond_0
    throw p1

    .line 120
    :cond_1
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string p2, "Attempting to set custom attribute with null key, ignoring."

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method a(Ljava/lang/String;Ljava/lang/Thread$UncaughtExceptionHandler;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;)V
    .locals 6

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/k;->n:Lcom/aliyun/emas/apm/settings/SettingProvider;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/k;->m:Lcom/aliyun/emas/apm/crash/x0;

    .line 8
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;)V

    .line 9
    new-instance v1, Lcom/aliyun/emas/apm/crash/k$a;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/crash/k$a;-><init>(Lcom/aliyun/emas/apm/crash/k;)V

    .line 20
    new-instance p1, Lcom/aliyun/emas/apm/crash/s;

    iget-object v5, p0, Lcom/aliyun/emas/apm/crash/k;->j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    move-object v0, p1

    move-object v2, p3

    move-object v3, p4

    move-object v4, p2

    invoke-direct/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/s;-><init>(Lcom/aliyun/emas/apm/crash/s$a;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;Ljava/lang/Thread$UncaughtExceptionHandler;Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k;->l:Lcom/aliyun/emas/apm/crash/s;

    .line 23
    invoke-static {p1}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    return-void
.end method

.method a(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 8

    .line 112
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-object v6, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 114
    new-instance v7, Lcom/aliyun/emas/apm/crash/k$f;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p2

    move-object v3, p1

    invoke-direct/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/k$f;-><init>(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/Throwable;Ljava/lang/Thread;J)V

    invoke-virtual {v6, v7}, Lcom/aliyun/emas/apm/crash/j;->a(Ljava/lang/Runnable;)Lcom/google/android/gms/tasks/Task;

    return-void
.end method

.method a(Ljava/util/Map;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 121
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/c1;->a(Ljava/util/Map;)V

    return-void
.end method

.method a()Z
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->c:Lcom/aliyun/emas/apm/crash/m;

    .line 92
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/m;->c()Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_1

    .line 95
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/k;->b()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k;->j:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    .line 96
    invoke-interface {v2, v0}, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;->hasCrashDataForSession(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1

    .line 99
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v2, "Found previous crash marker."

    invoke-virtual {v0, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->c:Lcom/aliyun/emas/apm/crash/m;

    .line 100
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/m;->d()Z

    return v1
.end method

.method b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 2
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/c1;->a(Ljava/lang/String;)V

    return-void
.end method

.method b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 3
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/c1;->b(Ljava/lang/String;Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/k;->a:Landroid/content/Context;

    if-eqz p2, :cond_1

    .line 5
    invoke-static {p2}, Lcom/aliyun/emas/apm/crash/i;->g(Landroid/content/Context;)Z

    move-result p2

    if-nez p2, :cond_0

    goto :goto_0

    .line 6
    :cond_0
    throw p1

    .line 8
    :cond_1
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string p2, "Attempting to set custom attribute with null key, ignoring."

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method b(Lcom/aliyun/emas/apm/crash/x0;)Z
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->e:Lcom/aliyun/emas/apm/crash/j;

    .line 11
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/j;->a()V

    .line 13
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/k;->c()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 14
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "Skipping session finalization because a crash has already occurred."

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    return v1

    .line 18
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v2, "Finalizing previously open sessions."

    invoke-virtual {v0, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    const/4 v0, 0x1

    .line 20
    :try_start_0
    invoke-direct {p0, v0, p1}, Lcom/aliyun/emas/apm/crash/k;->a(ZLcom/aliyun/emas/apm/crash/x0;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 25
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v1, "Closed all previously open sessions."

    invoke-virtual {p1, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    return v0

    :catch_0
    move-exception p1

    .line 26
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v2, "Unable to finalize previously open sessions."

    invoke-virtual {v0, v2, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    return v1
.end method

.method c(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 2
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/c1;->b(Ljava/lang/String;)V

    return-void
.end method

.method c()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k;->l:Lcom/aliyun/emas/apm/crash/s;

    if-eqz v0, :cond_0

    .line 3
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/s;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
