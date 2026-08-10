.class public Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field final a:Lcom/aliyun/emas/apm/crash/l;


# direct methods
.method private constructor <init>(Lcom/aliyun/emas/apm/crash/l;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    return-void
.end method

.method static a(Lcom/aliyun/emas/apm/ApmContext;Lcom/aliyun/emas/apm/ApmSession;Lcom/aliyun/emas/apm/inject/Deferred;Lcom/aliyun/emas/apm/events/Subscriber;Lcom/aliyun/emas/apm/settings/SettingProvider;Ljava/util/concurrent/ExecutorService;Ljava/util/concurrent/ExecutorService;)Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;
    .locals 15

    move-object/from16 v0, p4

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/ApmOptions;->isOpenDebug()Z

    move-result v1

    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->setOpenDebug(Z)V

    .line 2
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 3
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 4
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v5, "Initializing Apm Crash Analysis "

    invoke-direct {v3, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 7
    invoke-static {}, Lcom/aliyun/emas/apm/crash/l;->c()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, " for "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 8
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/Logger;->i(Ljava/lang/String;)V

    .line 14
    new-instance v10, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    invoke-direct {v10, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;-><init>(Landroid/content/Context;)V

    .line 15
    new-instance v9, Lcom/aliyun/emas/apm/crash/u;

    move-object v13, p0

    invoke-direct {v9, p0}, Lcom/aliyun/emas/apm/crash/u;-><init>(Lcom/aliyun/emas/apm/ApmContext;)V

    .line 16
    new-instance v14, Lcom/aliyun/emas/apm/crash/b0;

    .line 17
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v2

    invoke-virtual {v2}, Lcom/aliyun/emas/apm/ApmOptions;->getAppKey()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v2

    invoke-virtual {v2}, Lcom/aliyun/emas/apm/ApmOptions;->getAppSecret()Ljava/lang/String;

    move-result-object v6

    move-object v2, v14

    move-object v3, v1

    move-object/from16 v7, p1

    move-object v8, v9

    invoke-direct/range {v2 .. v8}, Lcom/aliyun/emas/apm/crash/b0;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/ApmSession;Lcom/aliyun/emas/apm/crash/u;)V

    .line 18
    new-instance v8, Lcom/aliyun/emas/apm/crash/n;

    move-object/from16 v2, p2

    invoke-direct {v8, v2}, Lcom/aliyun/emas/apm/crash/n;-><init>(Lcom/aliyun/emas/apm/inject/Deferred;)V

    const-string v2, "Crashlytics Exception Handler"

    .line 22
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/y;->a(Ljava/lang/String;)Ljava/util/concurrent/ExecutorService;

    move-result-object v11

    .line 24
    new-instance v2, Lcom/aliyun/emas/apm/crash/l;

    move-object v5, v2

    move-object v6, p0

    move-object v7, v14

    move-object/from16 v12, p3

    invoke-direct/range {v5 .. v12}, Lcom/aliyun/emas/apm/crash/l;-><init>(Lcom/aliyun/emas/apm/ApmContext;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;Lcom/aliyun/emas/apm/crash/u;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Ljava/util/concurrent/ExecutorService;Lcom/aliyun/emas/apm/events/Subscriber;)V

    .line 34
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v3

    invoke-virtual {v3}, Lcom/aliyun/emas/apm/ApmOptions;->getApplicationId()Ljava/lang/String;

    .line 36
    new-instance v3, Lcom/aliyun/emas/apm/crash/x;

    invoke-direct {v3, v1}, Lcom/aliyun/emas/apm/crash/x;-><init>(Landroid/content/Context;)V

    .line 45
    :try_start_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aliyun/emas/apm/ApmOptions;->getChannel()Ljava/lang/String;

    move-result-object v4

    .line 46
    invoke-static {v1, v14, v4, v3}, Lcom/aliyun/emas/apm/crash/a;->a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/b0;Ljava/lang/String;Lcom/aliyun/emas/apm/crash/x;)Lcom/aliyun/emas/apm/crash/a;

    move-result-object v1
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 56
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Installer package name is: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v5, v1, Lcom/aliyun/emas/apm/crash/a;->a:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    .line 59
    invoke-static/range {p5 .. p5}, Lcom/aliyun/emas/apm/crash/y;->a(Ljava/util/concurrent/Executor;)Ljava/util/concurrent/Executor;

    .line 61
    invoke-static {}, Lcom/aliyun/emas/apm/crash/w0;->a()Lcom/aliyun/emas/apm/crash/w0;

    move-result-object v3

    .line 63
    invoke-virtual {v2, v1, v0, v3}, Lcom/aliyun/emas/apm/crash/l;->a(Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/settings/SettingProvider;Lcom/aliyun/emas/apm/crash/x0;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 66
    invoke-virtual {v2, v3, v0}, Lcom/aliyun/emas/apm/crash/l;->b(Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/settings/SettingProvider;)Lcom/google/android/gms/tasks/Task;

    .line 69
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    invoke-direct {v0, v2}, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;-><init>(Lcom/aliyun/emas/apm/crash/l;)V

    return-object v0

    :catch_0
    move-exception v0

    .line 70
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    const-string v2, "Error retrieving app package info."

    invoke-virtual {v1, v2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public static getInstance()Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;
    .locals 2

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/ApmContext;->getInstance()Lcom/aliyun/emas/apm/ApmContext;

    move-result-object v0

    const-class v1, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    .line 2
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmContext;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    if-eqz v0, :cond_0

    return-object v0

    .line 4
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "ApmCrashAnalysis component is not present."

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public log(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;)V

    return-void
.end method

.method public recordException(Ljava/lang/Throwable;)V
    .locals 1

    if-nez p1, :cond_0

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "A null value was passed to recordException. Ignoring."

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 4
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/Throwable;)V

    return-void
.end method

.method public setCustomKey(Ljava/lang/String;D)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCustomKey(Ljava/lang/String;F)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 3
    invoke-static {p2}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCustomKey(Ljava/lang/String;I)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 4
    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCustomKey(Ljava/lang/String;J)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 5
    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCustomKey(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 6
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCustomKey(Ljava/lang/String;Z)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-static {p2}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setCustomKeys(Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;->a:Ljava/util/Map;

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/l;->a(Ljava/util/Map;)V

    return-void
.end method

.method public setUserId(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/l;->b(Ljava/lang/String;)V

    return-void
.end method
