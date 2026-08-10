.class public Lcom/taobao/tao/log/godeye/core/control/a;
.super Ljava/lang/Object;
.source "GodeyeJointPointCenter.java"

# interfaces
.implements Lcom/taobao/tao/log/godeye/api/b/c;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/godeye/core/control/a$e;,
        Lcom/taobao/tao/log/godeye/core/control/a$d;,
        Lcom/taobao/tao/log/godeye/core/control/a$a;,
        Lcom/taobao/tao/log/godeye/core/control/a$f;,
        Lcom/taobao/tao/log/godeye/core/control/a$c;,
        Lcom/taobao/tao/log/godeye/core/control/a$b;
    }
.end annotation


# instance fields
.field private a:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector<",
            "Lcom/taobao/tao/log/godeye/api/b/c$a;",
            ">;"
        }
    .end annotation
.end field

.field private a:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/taobao/tao/log/godeye/api/b/c$a;",
            ">;>;"
        }
    .end annotation
.end field

.field private b:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector<",
            "Lcom/taobao/tao/log/godeye/api/b/c$a;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/taobao/tao/log/godeye/api/b/c$a;",
            ">;>;"
        }
    .end annotation
.end field

.field private h:Ljava/lang/String;

.field private final mApplication:Landroid/app/Application;


# direct methods
.method constructor <init>(Landroid/app/Application;)V
    .locals 1

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 50
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/Vector;

    .line 55
    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/Vector;

    .line 61
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/concurrent/ConcurrentHashMap;

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a;->mApplication:Landroid/app/Application;

    .line 67
    new-instance v0, Lcom/taobao/tao/log/godeye/core/control/a$b;

    invoke-direct {v0, p0}, Lcom/taobao/tao/log/godeye/core/control/a$b;-><init>(Lcom/taobao/tao/log/godeye/core/control/a;)V

    invoke-virtual {p1, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    return-void
.end method

.method static synthetic a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 37
    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a;->h:Ljava/lang/String;

    return-object p1
.end method

.method private static a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 331
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "."

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/Vector;
    .locals 0

    .line 37
    iget-object p0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/Vector;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;
    .locals 0

    .line 37
    iget-object p0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    return-object p0
.end method

.method private a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 2

    .line 386
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v1, "lifecycle"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 387
    check-cast p1, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;

    .line 388
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;->page:Ljava/lang/String;

    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;->lifecycleMethod:Ljava/lang/String;

    invoke-direct {p0, v0, p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 393
    :cond_0
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v1, "notification"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 394
    check-cast p1, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;

    .line 395
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;->action:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 400
    :cond_1
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v1, "background"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 401
    invoke-direct {p0, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 406
    :cond_2
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v1, "foreground"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 407
    invoke-direct {p0, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 412
    :cond_3
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v1, "event"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 413
    check-cast p1, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;

    .line 414
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;->eventName:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    :cond_4
    return-void
.end method

.method private a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Z)V
    .locals 1

    if-eqz p3, :cond_0

    .line 342
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v0, "startup"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_0

    .line 343
    invoke-virtual {p2}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    return-void

    .line 348
    :cond_0
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v0, "lifecycle"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_1

    .line 349
    check-cast p1, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;

    .line 350
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;->page:Ljava/lang/String;

    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/LifecycleJointPoint;->lifecycleMethod:Ljava/lang/String;

    invoke-direct {p0, p3, p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 355
    :cond_1
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v0, "notification"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_2

    .line 356
    check-cast p1, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;

    .line 357
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/NotificationJointPoint;->action:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 362
    :cond_2
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v0, "background"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_3

    .line 363
    invoke-direct {p0, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 368
    :cond_3
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v0, "foreground"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_4

    .line 369
    invoke-direct {p0, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    return-void

    .line 374
    :cond_4
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v0, "event"

    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_5

    .line 375
    check-cast p1, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;

    .line 376
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/joint/point/EventJointPoint;->eventName:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    :cond_5
    return-void
.end method

.method private a(Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/Vector;

    .line 158
    invoke-virtual {v0, p1}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method static synthetic a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V
    .locals 0

    .line 37
    invoke-direct {p0, p1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/util/List;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 2

    .line 173
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 174
    invoke-virtual {v0, p1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 176
    new-instance p1, Lcom/taobao/tao/log/godeye/core/control/a$c;

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/core/control/a;->mApplication:Landroid/app/Application;

    invoke-direct {p1, v1, p2}, Lcom/taobao/tao/log/godeye/core/control/a$c;-><init>(Landroid/content/Context;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    iget-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/a;->mApplication:Landroid/app/Application;

    .line 177
    invoke-virtual {p2, p1, v0}, Landroid/app/Application;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 0

    .line 143
    invoke-static {p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 144
    invoke-virtual {p2, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/util/List;

    if-eqz p2, :cond_0

    .line 146
    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 148
    :cond_0
    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    .line 149
    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p3, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 150
    invoke-virtual {p3, p1, p2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void
.end method

.method private a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/taobao/tao/log/godeye/api/b/c$a;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    .line 198
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_1

    .line 199
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 200
    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    .line 201
    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/api/b/c$a;->a()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 202
    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method static synthetic b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 37
    invoke-static {p0, p1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic b(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/Vector;
    .locals 0

    .line 37
    iget-object p0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->a:Ljava/util/Vector;

    return-object p0
.end method

.method private b(Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/Vector;

    .line 165
    invoke-virtual {v0, p1}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method private b(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 181
    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-eqz v0, :cond_0

    .line 183
    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 185
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 186
    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 187
    invoke-virtual {p2, p1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Z)V
    .locals 6

    .line 87
    iget-object v0, p3, Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;->type:Ljava/lang/String;

    const-string v1, "timer"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 88
    move-object v0, p3

    check-cast v0, Lcom/taobao/android/tlog/protocol/model/joint/point/TimerJointPoint;

    .line 90
    iget v0, v0, Lcom/taobao/android/tlog/protocol/model/joint/point/TimerJointPoint;->waitMilliseconds:I

    int-to-long v0, v0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    const-wide/16 v0, -0x1

    .line 94
    :goto_0
    new-instance v3, Lcom/taobao/tao/log/godeye/core/control/a$d;

    invoke-direct {v3, p2}, Lcom/taobao/tao/log/godeye/core/control/a$d;-><init>(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    .line 95
    new-instance p2, Lcom/taobao/tao/log/godeye/core/control/a$e;

    invoke-direct {p2, p4}, Lcom/taobao/tao/log/godeye/core/control/a$e;-><init>(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    if-eqz v2, :cond_1

    const-wide/16 v4, 0x0

    cmp-long p4, v0, v4

    if-lez p4, :cond_1

    .line 98
    new-instance p4, Lcom/taobao/tao/log/godeye/core/control/a$f;

    invoke-direct {p4, v0, v1, v3, p2}, Lcom/taobao/tao/log/godeye/core/control/a$f;-><init>(JLcom/taobao/tao/log/godeye/api/b/c$a;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    invoke-direct {p0, p1, p4, p5}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Z)V

    :cond_1
    if-nez v2, :cond_2

    .line 107
    invoke-direct {p0, p1, v3, p5}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Z)V

    .line 108
    invoke-direct {p0, p3, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    :cond_2
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 2

    .line 118
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 122
    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-eqz v0, :cond_1

    .line 124
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 125
    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 128
    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
