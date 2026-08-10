.class public Lcom/aliyun/emas/apm/crash/l;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Landroid/content/Context;

.field private final b:Lcom/aliyun/emas/apm/ApmContext;

.field private final c:Lcom/aliyun/emas/apm/crash/u;

.field private final d:Lcom/aliyun/emas/apm/crash/m0;

.field private final e:J

.field private f:Lcom/aliyun/emas/apm/crash/m;

.field private g:Lcom/aliyun/emas/apm/crash/m;

.field private h:Z

.field private i:Lcom/aliyun/emas/apm/crash/k;

.field private final j:Lcom/aliyun/emas/apm/crash/b0;

.field private final k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

.field private final l:Ljava/util/concurrent/ExecutorService;

.field private final m:Lcom/aliyun/emas/apm/crash/j;

.field private final n:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

.field private o:Lcom/aliyun/emas/apm/events/Subscriber;


# direct methods
.method public static synthetic $r8$lambda$GCHbwogJWuzypY3abozFuS4zlaY(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/events/Event;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/l;->b(Lcom/aliyun/emas/apm/events/Event;)V

    return-void
.end method

.method public static synthetic $r8$lambda$d-MPn9mmXnYl2eyHYHf9KzHN_yc(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/events/Event;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/l;->a(Lcom/aliyun/emas/apm/events/Event;)V

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/ApmContext;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;Lcom/aliyun/emas/apm/crash/u;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Ljava/util/concurrent/ExecutorService;Lcom/aliyun/emas/apm/events/Subscriber;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l;->b:Lcom/aliyun/emas/apm/ApmContext;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/l;->c:Lcom/aliyun/emas/apm/crash/u;

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/ApmContext;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/l;->j:Lcom/aliyun/emas/apm/crash/b0;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/l;->n:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    iput-object p6, p0, Lcom/aliyun/emas/apm/crash/l;->l:Ljava/util/concurrent/ExecutorService;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    .line 9
    new-instance p1, Lcom/aliyun/emas/apm/crash/j;

    invoke-direct {p1, p6}, Lcom/aliyun/emas/apm/crash/j;-><init>(Ljava/util/concurrent/Executor;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l;->m:Lcom/aliyun/emas/apm/crash/j;

    iput-object p7, p0, Lcom/aliyun/emas/apm/crash/l;->o:Lcom/aliyun/emas/apm/events/Subscriber;

    .line 12
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/l;->e:J

    .line 13
    new-instance p1, Lcom/aliyun/emas/apm/crash/m0;

    invoke-direct {p1}, Lcom/aliyun/emas/apm/crash/m0;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l;->d:Lcom/aliyun/emas/apm/crash/m0;

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/l;)Lcom/aliyun/emas/apm/crash/m;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/l;->f:Lcom/aliyun/emas/apm/crash/m;

    return-object p0
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)Lcom/google/android/gms/tasks/Task;
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)Lcom/google/android/gms/tasks/Task;

    move-result-object p0

    return-object p0
.end method

.method private a(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)Lcom/google/android/gms/tasks/Task;
    .locals 2

    const-string v0, "Collection of crash reports disabled in Crashlytics settings."

    .line 133
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l;->e()V

    .line 136
    :try_start_0
    invoke-interface {p1}, Lcom/aliyun/emas/apm/crash/x0;->getSettingsSync()Lcom/aliyun/emas/apm/crash/v0;

    move-result-object v1

    .line 138
    iget-object v1, v1, Lcom/aliyun/emas/apm/crash/v0;->b:Lcom/aliyun/emas/apm/crash/v0$a;

    iget-boolean v1, v1, Lcom/aliyun/emas/apm/crash/v0$a;->a:Z

    if-nez v1, :cond_0

    .line 139
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 142
    new-instance p1, Ljava/lang/RuntimeException;

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forException(Ljava/lang/Exception;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 167
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l;->d()V

    return-object p1

    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 168
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/k;->b(Lcom/aliyun/emas/apm/crash/x0;)Z

    move-result p1

    if-nez p1, :cond_1

    .line 169
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "Previous sessions could not be finalized."

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    :cond_1
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 175
    invoke-interface {p2}, Lcom/aliyun/emas/apm/settings/SettingProvider;->getSettingsAsync()Lcom/google/android/gms/tasks/Task;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 189
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l;->d()V

    return-object p1

    :catchall_0
    move-exception p1

    goto :goto_0

    :catch_0
    move-exception p1

    .line 190
    :try_start_2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v0, "Crashlytics encountered a problem during asynchronous initialization."

    .line 191
    invoke-virtual {p2, v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 192
    invoke-static {p1}, Lcom/google/android/gms/tasks/Tasks;->forException(Ljava/lang/Exception;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 202
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l;->d()V

    return-object p1

    .line 203
    :goto_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l;->d()V

    .line 204
    throw p1
.end method

.method private a()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->m:Lcom/aliyun/emas/apm/crash/j;

    .line 209
    new-instance v1, Lcom/aliyun/emas/apm/crash/l$e;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/crash/l$e;-><init>(Lcom/aliyun/emas/apm/crash/l;)V

    .line 210
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    .line 220
    :try_start_0
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/d1;->a(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 227
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v1, v0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/aliyun/emas/apm/crash/l;->h:Z

    return-void

    :catch_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/aliyun/emas/apm/crash/l;->h:Z

    return-void
.end method

.method private a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/c1;)V
    .locals 2

    .line 229
    new-instance v0, Lcom/aliyun/emas/apm/crash/l$f;

    invoke-direct {v0, p0, p2}, Lcom/aliyun/emas/apm/crash/l$f;-><init>(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/c1;)V

    .line 241
    new-instance p2, Landroid/content/IntentFilter;

    invoke-direct {p2}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    .line 242
    invoke-virtual {p2, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 243
    invoke-virtual {p1, v0, p2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method private synthetic a(Lcom/aliyun/emas/apm/events/Event;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 132
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/events/Event;->getPayload()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/user/UserId;

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/user/UserId;->getUserId()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/k;->b(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/crash/l;)Lcom/aliyun/emas/apm/crash/k;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    return-object p0
.end method

.method private synthetic b(Lcom/aliyun/emas/apm/events/Event;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/events/Event;->getPayload()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/user/UserNick;

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/user/UserNick;->getUserNick()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/k;->c(Ljava/lang/String;)V

    return-void
.end method

.method public static c()Ljava/lang/String;
    .locals 1

    const-string v0, "3.2.0"

    return-object v0
.end method

.method private c(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)V
    .locals 2

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/l$c;

    invoke-direct {v0, p0, p1, p2}, Lcom/aliyun/emas/apm/crash/l$c;-><init>(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/l;->l:Ljava/util/concurrent/ExecutorService;

    .line 10
    invoke-interface {p1, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object p1

    .line 12
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v0, "Crashlytics detected incomplete initialization on previous app launch. Will initialize synchronously."

    .line 13
    invoke-virtual {p2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 18
    :try_start_0
    sget-object p2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v0, 0x3

    invoke-interface {p1, v0, v1, p2}, Ljava/util/concurrent/Future;->get(JLjava/util/concurrent/TimeUnit;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/TimeoutException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 24
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v0, "Crashlytics timed out during initialization."

    invoke-virtual {p2, v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    :catch_1
    move-exception p1

    .line 25
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v0, "Crashlytics encountered a problem during initialization."

    invoke-virtual {p2, v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    :catch_2
    move-exception p1

    .line 26
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p2

    const-string v0, "Crashlytics was interrupted during initialization."

    invoke-virtual {p2, v0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 206
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2, p1}, Lcom/aliyun/emas/apm/crash/k;->a(JLjava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 207
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/Throwable;)V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 205
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    return-void
.end method

.method public a(Ljava/util/Map;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 208
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/util/Map;)V

    return-void
.end method

.method public a(Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;)Z
    .locals 28

    move-object/from16 v1, p0

    move-object/from16 v0, p2

    move-object/from16 v12, p3

    .line 3
    new-instance v2, Lcom/aliyun/emas/apm/crash/h;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/crash/h;-><init>()V

    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/h;->a()Ljava/lang/String;

    move-result-object v13

    const/4 v14, 0x0

    .line 5
    :try_start_0
    new-instance v2, Lcom/aliyun/emas/apm/crash/m;

    const-string v3, "crash_marker"

    iget-object v4, v1, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v2, v3, v4}, Lcom/aliyun/emas/apm/crash/m;-><init>(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    iput-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->g:Lcom/aliyun/emas/apm/crash/m;

    .line 6
    new-instance v2, Lcom/aliyun/emas/apm/crash/m;

    const-string v3, "initialization_marker"

    iget-object v4, v1, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v2, v3, v4}, Lcom/aliyun/emas/apm/crash/m;-><init>(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    iput-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->f:Lcom/aliyun/emas/apm/crash/m;

    .line 8
    new-instance v15, Lcom/aliyun/emas/apm/crash/c1;

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iget-object v3, v1, Lcom/aliyun/emas/apm/crash/l;->m:Lcom/aliyun/emas/apm/crash/j;

    invoke-direct {v15, v13, v2, v3}, Lcom/aliyun/emas/apm/crash/c1;-><init>(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/j;)V

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->a:Landroid/content/Context;

    .line 10
    invoke-direct {v1, v2, v15}, Lcom/aliyun/emas/apm/crash/l;->a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/c1;)V

    .line 11
    new-instance v11, Lcom/aliyun/emas/apm/crash/e0;

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v11, v2}, Lcom/aliyun/emas/apm/crash/e0;-><init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    .line 12
    new-instance v8, Lcom/aliyun/emas/apm/crash/g0;

    const/4 v10, 0x1

    new-array v2, v10, [Lcom/aliyun/emas/apm/crash/y0;

    new-instance v3, Lcom/aliyun/emas/apm/crash/q0;

    const/16 v4, 0xa

    invoke-direct {v3, v4}, Lcom/aliyun/emas/apm/crash/q0;-><init>(I)V

    aput-object v3, v2, v14

    const/16 v3, 0x400

    invoke-direct {v8, v3, v2}, Lcom/aliyun/emas/apm/crash/g0;-><init>(I[Lcom/aliyun/emas/apm/crash/y0;)V

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->a:Landroid/content/Context;

    iget-object v3, v1, Lcom/aliyun/emas/apm/crash/l;->j:Lcom/aliyun/emas/apm/crash/b0;

    iget-object v4, v1, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iget-object v5, v1, Lcom/aliyun/emas/apm/crash/l;->b:Lcom/aliyun/emas/apm/ApmContext;

    .line 26
    invoke-virtual {v5}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v16

    iget-object v9, v1, Lcom/aliyun/emas/apm/crash/l;->d:Lcom/aliyun/emas/apm/crash/m0;

    move-object/from16 v5, p1

    move-object v6, v11

    move-object v7, v15

    move-object/from16 v17, v9

    move-object/from16 v9, p3

    move/from16 v27, v10

    move-object/from16 v10, v16

    move-object/from16 v24, v11

    move-object/from16 v11, v17

    .line 27
    invoke-static/range {v2 .. v11}, Lcom/aliyun/emas/apm/crash/u0;->a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/c1;Lcom/aliyun/emas/apm/crash/y0;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/ApmOptions;Lcom/aliyun/emas/apm/crash/m0;)Lcom/aliyun/emas/apm/crash/u0;

    move-result-object v25

    .line 39
    new-instance v2, Lcom/aliyun/emas/apm/crash/k;

    iget-object v3, v1, Lcom/aliyun/emas/apm/crash/l;->a:Landroid/content/Context;

    iget-object v4, v1, Lcom/aliyun/emas/apm/crash/l;->m:Lcom/aliyun/emas/apm/crash/j;

    iget-object v5, v1, Lcom/aliyun/emas/apm/crash/l;->j:Lcom/aliyun/emas/apm/crash/b0;

    iget-object v6, v1, Lcom/aliyun/emas/apm/crash/l;->c:Lcom/aliyun/emas/apm/crash/u;

    iget-object v7, v1, Lcom/aliyun/emas/apm/crash/l;->k:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    iget-object v8, v1, Lcom/aliyun/emas/apm/crash/l;->g:Lcom/aliyun/emas/apm/crash/m;

    iget-object v9, v1, Lcom/aliyun/emas/apm/crash/l;->n:Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    move-object v10, v15

    move-object v15, v2

    move-object/from16 v16, v3

    move-object/from16 v17, v4

    move-object/from16 v18, v5

    move-object/from16 v19, v6

    move-object/from16 v20, v7

    move-object/from16 v21, v8

    move-object/from16 v22, p1

    move-object/from16 v23, v10

    move-object/from16 v26, v9

    invoke-direct/range {v15 .. v26}, Lcom/aliyun/emas/apm/crash/k;-><init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/j;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/u;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/m;Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/crash/c1;Lcom/aliyun/emas/apm/crash/e0;Lcom/aliyun/emas/apm/crash/u0;Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;)V

    iput-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    iget-object v3, v1, Lcom/aliyun/emas/apm/crash/l;->b:Lcom/aliyun/emas/apm/ApmContext;

    .line 53
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v3

    invoke-virtual {v3}, Lcom/aliyun/emas/apm/ApmOptions;->getUserId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/k;->b(Ljava/lang/String;)V

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    iget-object v3, v1, Lcom/aliyun/emas/apm/crash/l;->b:Lcom/aliyun/emas/apm/ApmContext;

    .line 54
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v3

    invoke-virtual {v3}, Lcom/aliyun/emas/apm/ApmOptions;->getUserNick()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/k;->c(Ljava/lang/String;)V

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->o:Lcom/aliyun/emas/apm/events/Subscriber;

    .line 55
    const-class v3, Lcom/aliyun/emas/apm/user/UserId;

    new-instance v4, Lcom/aliyun/emas/apm/crash/l$$ExternalSyntheticLambda0;

    invoke-direct {v4, v1}, Lcom/aliyun/emas/apm/crash/l$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/l;)V

    invoke-interface {v2, v3, v4}, Lcom/aliyun/emas/apm/events/Subscriber;->subscribe(Ljava/lang/Class;Lcom/aliyun/emas/apm/events/EventHandler;)V

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->o:Lcom/aliyun/emas/apm/events/Subscriber;

    .line 56
    const-class v3, Lcom/aliyun/emas/apm/user/UserNick;

    new-instance v4, Lcom/aliyun/emas/apm/crash/l$$ExternalSyntheticLambda1;

    invoke-direct {v4, v1}, Lcom/aliyun/emas/apm/crash/l$$ExternalSyntheticLambda1;-><init>(Lcom/aliyun/emas/apm/crash/l;)V

    invoke-interface {v2, v3, v4}, Lcom/aliyun/emas/apm/events/Subscriber;->subscribe(Ljava/lang/Class;Lcom/aliyun/emas/apm/events/EventHandler;)V

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->b:Lcom/aliyun/emas/apm/ApmContext;

    .line 58
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v2

    invoke-virtual {v2}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 60
    new-instance v3, Lcom/aliyun/emas/apm/crash/l$a;

    invoke-direct {v3, v1}, Lcom/aliyun/emas/apm/crash/l$a;-><init>(Lcom/aliyun/emas/apm/crash/l;)V

    invoke-virtual {v2, v3}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    .line 102
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/aliyun/emas/apm/crash/l;->b()Z

    move-result v2

    .line 104
    invoke-direct/range {p0 .. p0}, Lcom/aliyun/emas/apm/crash/l;->a()V

    iget-object v3, v1, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 107
    invoke-static {}, Ljava/lang/Thread;->getDefaultUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;

    move-result-object v4

    .line 108
    invoke-virtual {v3, v13, v4, v0, v12}, Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;Ljava/lang/Thread$UncaughtExceptionHandler;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;)V

    if-eqz v2, :cond_1

    iget-object v2, v1, Lcom/aliyun/emas/apm/crash/l;->a:Landroid/content/Context;

    .line 111
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/i;->c(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 112
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    const-string v3, "Crashlytics did not finish previous background initialization. Initializing synchronously."

    .line 113
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    .line 117
    invoke-direct {v1, v12, v0}, Lcom/aliyun/emas/apm/crash/l;->c(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v14

    .line 128
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v2, "Successfully configured exception handler."

    invoke-virtual {v0, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;)V

    return v27

    :catch_0
    move-exception v0

    .line 129
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    const-string v3, "Crashlytics was not started due to an exception during initialization"

    .line 130
    invoke-virtual {v2, v3, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 v0, 0x0

    iput-object v0, v1, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    return v14
.end method

.method public b(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)Lcom/google/android/gms/tasks/Task;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->l:Ljava/util/concurrent/ExecutorService;

    .line 3
    new-instance v1, Lcom/aliyun/emas/apm/crash/l$b;

    invoke-direct {v1, p0, p1, p2}, Lcom/aliyun/emas/apm/crash/l$b;-><init>(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)V

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/d1;->a(Ljava/util/concurrent/Executor;Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 4
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/k;->b(Ljava/lang/String;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->i:Lcom/aliyun/emas/apm/crash/k;

    .line 5
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/k;->b(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method b()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->f:Lcom/aliyun/emas/apm/crash/m;

    .line 6
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/m;->c()Z

    move-result v0

    return v0
.end method

.method d()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->m:Lcom/aliyun/emas/apm/crash/j;

    .line 1
    new-instance v1, Lcom/aliyun/emas/apm/crash/l$d;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/crash/l$d;-><init>(Lcom/aliyun/emas/apm/crash/l;)V

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    return-void
.end method

.method e()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->m:Lcom/aliyun/emas/apm/crash/j;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/j;->a()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l;->f:Lcom/aliyun/emas/apm/crash/m;

    .line 5
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/m;->a()Z

    .line 6
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Initialization marker file was created."

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    return-void
.end method
