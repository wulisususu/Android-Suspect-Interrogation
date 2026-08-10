.class public Lcom/aliyun/emas/apm/Apm;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static b:Lcom/aliyun/emas/apm/ApmOptions;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/aliyun/emas/apm/Apm;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static preStart(Lcom/aliyun/emas/apm/ApmOptions;)V
    .locals 2

    sget-object v0, Lcom/aliyun/emas/apm/Apm;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sput-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 7
    :try_start_0
    invoke-static {}, Lcom/alibaba/ha/adapter/AliHaAdapter;->getInstance()Lcom/alibaba/ha/adapter/AliHaAdapter;

    move-result-object v0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/ha/adapter/AliHaAdapter;->preStart(Landroid/app/Application;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 12
    :catchall_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object p0

    invoke-static {p0}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->initialize(Landroid/app/Application;)V

    .line 13
    invoke-static {}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->getInstance()Lcom/google/android/gms/common/api/internal/BackgroundDetector;

    move-result-object p0

    invoke-static {}, Lcom/aliyun/emas/apm/f;->a()Lcom/aliyun/emas/apm/f;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/google/android/gms/common/api/internal/BackgroundDetector;->addListener(Lcom/google/android/gms/common/api/internal/BackgroundDetector$BackgroundStateChangeListener;)V

    return-void
.end method

.method public static setUserId(Ljava/lang/String;)V
    .locals 3

    sget-object v0, Lcom/aliyun/emas/apm/Apm;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const-string v1, "userId is longer than 128 char"

    const/16 v2, 0x80

    if-eqz v0, :cond_2

    .line 3
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_1

    sget-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 4
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result p0

    if-nez p0, :cond_0

    return-void

    .line 5
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 11
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/f;->a()Lcom/aliyun/emas/apm/f;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/f;->b(Ljava/lang/String;)V

    .line 12
    invoke-static {}, Lcom/aliyun/emas/apm/ApmContext;->getInstance()Lcom/aliyun/emas/apm/ApmContext;

    move-result-object v0

    const-class v1, Lcom/aliyun/emas/apm/events/Publisher;

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmContext;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/events/Publisher;

    .line 13
    new-instance v1, Lcom/aliyun/emas/apm/events/Event;

    new-instance v2, Lcom/aliyun/emas/apm/user/UserId;

    invoke-direct {v2, p0}, Lcom/aliyun/emas/apm/user/UserId;-><init>(Ljava/lang/String;)V

    const-class p0, Lcom/aliyun/emas/apm/user/UserId;

    invoke-direct {v1, p0, v2}, Lcom/aliyun/emas/apm/events/Event;-><init>(Ljava/lang/Class;Ljava/lang/Object;)V

    .line 14
    invoke-interface {v0, v1}, Lcom/aliyun/emas/apm/events/Publisher;->publish(Lcom/aliyun/emas/apm/events/Event;)V

    goto :goto_0

    :cond_2
    sget-object v0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    if-eqz v0, :cond_5

    .line 17
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_4

    sget-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 18
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result p0

    if-nez p0, :cond_3

    return-void

    .line 19
    :cond_3
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 25
    :cond_4
    new-instance v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;

    sget-object v1, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;-><init>(Lcom/aliyun/emas/apm/ApmOptions;)V

    .line 26
    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->setUserId(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object p0

    .line 27
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->build()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object p0

    sput-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    :cond_5
    :goto_0
    return-void
.end method

.method public static setUserNick(Ljava/lang/String;)V
    .locals 3

    sget-object v0, Lcom/aliyun/emas/apm/Apm;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const-string v1, "userNick is longer than 128 char"

    const/16 v2, 0x80

    if-eqz v0, :cond_2

    .line 3
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_1

    sget-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 4
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result p0

    if-nez p0, :cond_0

    return-void

    .line 5
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 11
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/f;->a()Lcom/aliyun/emas/apm/f;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/f;->c(Ljava/lang/String;)V

    .line 12
    invoke-static {}, Lcom/aliyun/emas/apm/ApmContext;->getInstance()Lcom/aliyun/emas/apm/ApmContext;

    move-result-object v0

    const-class v1, Lcom/aliyun/emas/apm/events/Publisher;

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/ApmContext;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/events/Publisher;

    .line 13
    new-instance v1, Lcom/aliyun/emas/apm/events/Event;

    new-instance v2, Lcom/aliyun/emas/apm/user/UserNick;

    invoke-direct {v2, p0}, Lcom/aliyun/emas/apm/user/UserNick;-><init>(Ljava/lang/String;)V

    const-class p0, Lcom/aliyun/emas/apm/user/UserNick;

    invoke-direct {v1, p0, v2}, Lcom/aliyun/emas/apm/events/Event;-><init>(Ljava/lang/Class;Ljava/lang/Object;)V

    .line 14
    invoke-interface {v0, v1}, Lcom/aliyun/emas/apm/events/Publisher;->publish(Lcom/aliyun/emas/apm/events/Event;)V

    goto :goto_0

    :cond_2
    sget-object v0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    if-eqz v0, :cond_5

    .line 17
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-le v0, v2, :cond_4

    sget-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 18
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result p0

    if-nez p0, :cond_3

    return-void

    .line 19
    :cond_3
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 25
    :cond_4
    new-instance v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;

    sget-object v1, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/ApmOptions$Builder;-><init>(Lcom/aliyun/emas/apm/ApmOptions;)V

    .line 26
    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->setUserNick(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;

    move-result-object p0

    .line 27
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions$Builder;->build()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object p0

    sput-object p0, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    :cond_5
    :goto_0
    return-void
.end method

.method public static start()Z
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/aliyun/emas/apm/Apm;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    .line 1
    invoke-virtual {v1, v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_2

    sget-object v3, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 2
    invoke-static {v3}, Lcom/aliyun/emas/apm/ApmContext;->initialize(Lcom/aliyun/emas/apm/ApmOptions;)Lcom/aliyun/emas/apm/ApmContext;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v4, "Apm"

    if-nez v3, :cond_0

    :try_start_1
    const-string v2, "Apm initialization unsuccessful"

    .line 3
    invoke-static {v4, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 4
    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    goto :goto_0

    :cond_0
    sget-object v1, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    .line 6
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object v1

    invoke-static {v1}, Lcom/aliyun/emas/apm/util/ProcessUtils;->isMainProcess(Landroid/app/Application;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 8
    invoke-static {}, Lcom/aliyun/emas/apm/f;->a()Lcom/aliyun/emas/apm/f;

    move-result-object v1

    sget-object v3, Lcom/aliyun/emas/apm/Apm;->b:Lcom/aliyun/emas/apm/ApmOptions;

    invoke-static {}, Lcom/aliyun/emas/apm/ApmContext;->getApmSession()Lcom/aliyun/emas/apm/ApmSession;

    move-result-object v5

    invoke-virtual {v1, v3, v5}, Lcom/aliyun/emas/apm/f;->a(Lcom/aliyun/emas/apm/ApmOptions;Lcom/aliyun/emas/apm/ApmSession;)V

    :cond_1
    const-string v1, "Apm initialization successful"

    .line 10
    invoke-static {v4, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return v2

    :catch_0
    sget-object v1, Lcom/aliyun/emas/apm/Apm;->a:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 15
    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :cond_2
    :goto_0
    return v0
.end method
