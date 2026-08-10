.class public Lcom/taobao/accs/net/w;
.super Lcom/taobao/accs/net/b;
.source "Taobao"

# interfaces
.implements Lorg/android/spdy/SessionCb;
.implements Lorg/android/spdy/Spdycb;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/net/w$a;
    }
.end annotation


# instance fields
.field private final A:Ljava/lang/Object;

.field private B:J

.field private C:J

.field private D:J

.field private E:J

.field private F:I

.field private G:Ljava/lang/String;

.field private H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

.field private I:Lcom/taobao/accs/ut/a/c;

.field private J:Z

.field private K:Ljava/lang/String;

.field private L:Z

.field private M:Lcom/taobao/accs/net/g;

.field private N:Ljava/lang/String;

.field protected n:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field protected o:Ljava/lang/String;

.field protected p:I

.field protected q:Ljava/lang/String;

.field protected r:I

.field private s:I

.field private final t:Ljava/util/LinkedList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedList<",
            "Lcom/taobao/accs/data/Message;",
            ">;"
        }
    .end annotation
.end field

.field private u:Lcom/taobao/accs/net/w$a;

.field private v:Z

.field private w:Ljava/lang/String;

.field private x:Ljava/lang/String;

.field private y:Lorg/android/spdy/SpdyAgent;

.field private z:Lorg/android/spdy/SpdySession;


# direct methods
.method public constructor <init>(Landroid/content/Context;ILjava/lang/String;)V
    .locals 0

    .line 129
    invoke-direct {p0, p1, p2, p3}, Lcom/taobao/accs/net/b;-><init>(Landroid/content/Context;ILjava/lang/String;)V

    const/4 p1, 0x3

    iput p1, p0, Lcom/taobao/accs/net/w;->s:I

    .line 77
    new-instance p1, Ljava/util/LinkedList;

    invoke-direct {p1}, Ljava/util/LinkedList;-><init>()V

    iput-object p1, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/accs/net/w;->v:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/accs/net/w;->y:Lorg/android/spdy/SpdyAgent;

    iput-object p1, p0, Lcom/taobao/accs/net/w;->z:Lorg/android/spdy/SpdySession;

    .line 91
    new-instance p2, Ljava/lang/Object;

    invoke-direct {p2}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    const/4 p2, -0x1

    iput p2, p0, Lcom/taobao/accs/net/w;->F:I

    iput-object p1, p0, Lcom/taobao/accs/net/w;->G:Ljava/lang/String;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/accs/net/w;->J:Z

    const-string p2, ""

    iput-object p2, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    iput-boolean p1, p0, Lcom/taobao/accs/net/w;->L:Z

    .line 130
    new-instance p1, Lcom/taobao/accs/net/g;

    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Lcom/taobao/accs/net/g;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    .line 131
    invoke-direct {p0}, Lcom/taobao/accs/net/w;->w()V

    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/net/w;J)J
    .locals 0

    .line 57
    iput-wide p1, p0, Lcom/taobao/accs/net/w;->B:J

    return-wide p1
.end method

.method static synthetic a(Lcom/taobao/accs/net/w;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 57
    iput-object p1, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;
    .locals 0

    .line 57
    iget-object p0, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    return-object p0
.end method

.method private a(Lcom/alibaba/sdk/android/error/ErrorCode;)V
    .locals 9

    const/4 v0, 0x0

    .line 1030
    iput-object v0, p0, Lcom/taobao/accs/net/w;->k:Ljava/lang/String;

    .line 1031
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->u:Lcom/taobao/accs/net/w$a;

    if-eqz v0, :cond_0

    .line 1035
    iget v0, v0, Lcom/taobao/accs/net/w$a;->a:I

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 1037
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "code not 200 is"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/accs/net/w;->L:Z

    .line 1039
    iget v1, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez v1, :cond_1

    const-string v1, "service"

    goto :goto_1

    :cond_1
    const-string v1, "inapp"

    .line 1040
    :goto_1
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v2

    const v3, 0x101d1

    const-string v4, "CONNECTED NO 200 "

    invoke-virtual {v4, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/16 v0, 0xde

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    iget-object v0, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v8

    move-object v5, p1

    invoke-virtual/range {v2 .. v8}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/String;)V

    .line 1041
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "accs"

    const-string v2, "auth"

    invoke-static {v1, v2, v0, p1, v0}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private a(Lcom/taobao/accs/data/Message;)V
    .locals 6

    .line 286
    iget-object v0, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    invoke-virtual {v0}, Ljava/util/LinkedList;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_2

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 290
    invoke-virtual {v0}, Ljava/util/LinkedList;->size()I

    move-result v0

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    :goto_0
    if-ltz v0, :cond_6

    iget-object v2, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 291
    invoke-virtual {v2, v0}, Ljava/util/LinkedList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/accs/data/Message;

    if-eqz v2, :cond_5

    .line 292
    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v3, :cond_5

    .line 293
    invoke-virtual {v2}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 294
    iget-object v3, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    packed-switch v3, :pswitch_data_0

    goto :goto_1

    .line 311
    :pswitch_0
    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x5

    if-eq v3, v4, :cond_1

    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 312
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x6

    if-ne v3, v4, :cond_4

    :cond_1
    iget-object v3, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 313
    invoke-virtual {v3, v0}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    goto :goto_1

    .line 304
    :pswitch_1
    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x3

    if-eq v3, v4, :cond_2

    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 305
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x4

    if-ne v3, v4, :cond_4

    :cond_2
    iget-object v3, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 306
    invoke-virtual {v3, v0}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    goto :goto_1

    .line 297
    :pswitch_2
    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-eq v3, v1, :cond_3

    iget-object v3, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 298
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, 0x2

    if-ne v3, v4, :cond_4

    :cond_3
    iget-object v3, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 299
    invoke-virtual {v3, v0}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    .line 318
    :cond_4
    :goto_1
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "clearRepeatControlCommand message:"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v5, v2, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 319
    invoke-virtual {v2}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    .line 318
    invoke-static {v3, v2, v4}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_5
    add-int/lit8 v0, v0, -0x1

    goto/16 :goto_0

    .line 322
    :cond_6
    iget-object v0, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    if-eqz v0, :cond_7

    .line 323
    iget-object v0, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v0, p1}, Lcom/taobao/accs/data/d;->b(Lcom/taobao/accs/data/Message;)V

    :cond_7
    :goto_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_2
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lcom/taobao/accs/net/w;Lcom/taobao/accs/data/Message;)V
    .locals 0

    .line 57
    invoke-direct {p0, p1}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/data/Message;)V

    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/net/w;Z)Z
    .locals 0

    .line 57
    iput-boolean p1, p0, Lcom/taobao/accs/net/w;->J:Z

    return p1
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 9

    .line 486
    invoke-static {}, Lcom/taobao/accs/utl/Utils;->getMode()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x2

    if-ne v0, v2, :cond_0

    return v1

    .line 490
    :cond_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 491
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_7

    :cond_1
    const/4 v0, 0x3

    .line 492
    invoke-direct {p0, v0}, Lcom/taobao/accs/net/w;->c(I)V

    .line 496
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_2

    goto :goto_0

    .line 498
    :cond_2
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_3

    move v1, v2

    goto :goto_0

    .line 500
    :cond_3
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_4

    move v1, v0

    :cond_4
    :goto_0
    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 503
    invoke-virtual {p1, v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setFailReason(I)V

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 504
    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onConnectStop()V

    .line 505
    iget p1, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez p1, :cond_5

    const-string p1, "service"

    goto :goto_1

    :cond_5
    const-string p1, "inapp"

    :goto_1
    iget-object p2, p0, Lcom/taobao/accs/net/w;->u:Lcom/taobao/accs/net/w$a;

    const/4 p3, 0x0

    if-eqz p2, :cond_6

    .line 509
    iget p2, p2, Lcom/taobao/accs/net/w$a;->a:I

    goto :goto_2

    :cond_6
    move p2, p3

    .line 511
    :goto_2
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v2

    const v3, 0x101d1

    const-string v0, "DISCONNECT "

    invoke-virtual {v0, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 512
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/16 p1, 0xde

    .line 513
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    iget-object p1, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    filled-new-array {p1, v0}, [Ljava/lang/String;

    move-result-object v8

    .line 511
    invoke-virtual/range {v2 .. v8}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/String;)V

    .line 514
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "retrytimes:"

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, ""

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string v1, "accs"

    const-string v2, "connect"

    invoke-static {v1, v2, p1, p2, v0}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move v1, p3

    :cond_7
    return v1
.end method

.method static synthetic b(Lcom/taobao/accs/net/w;)I
    .locals 0

    .line 57
    iget p0, p0, Lcom/taobao/accs/net/w;->s:I

    return p0
.end method

.method static synthetic b(Lcom/taobao/accs/net/w;J)J
    .locals 0

    .line 57
    iput-wide p1, p0, Lcom/taobao/accs/net/w;->C:J

    return-wide p1
.end method

.method static synthetic b(Lcom/taobao/accs/net/w;Ljava/lang/String;)V
    .locals 0

    .line 57
    invoke-direct {p0, p1}, Lcom/taobao/accs/net/w;->d(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lcom/taobao/accs/net/w;Z)Z
    .locals 0

    .line 57
    iput-boolean p1, p0, Lcom/taobao/accs/net/w;->L:Z

    return p1
.end method

.method static synthetic c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;
    .locals 0

    .line 57
    iget-object p0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    return-object p0
.end method

.method private declared-synchronized c(I)V
    .locals 9

    monitor-enter p0

    .line 531
    :try_start_0
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "notifyStatus start"

    const/4 v2, 0x2

    new-array v3, v2, [Ljava/lang/Object;

    const-string v4, "status"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {p0, p1}, Lcom/taobao/accs/net/w;->a(I)Ljava/lang/String;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v3, v6

    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget v0, p0, Lcom/taobao/accs/net/w;->s:I

    if-ne p1, v0, :cond_0

    .line 533
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const-string v0, "ignore notifyStatus"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-static {p1, v0, v1}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 534
    monitor-exit p0

    return-void

    :cond_0
    :try_start_1
    iput p1, p0, Lcom/taobao/accs/net/w;->s:I

    if-eq p1, v6, :cond_4

    if-eq p1, v2, :cond_2

    const/4 v0, 0x3

    if-eq p1, v0, :cond_1

    goto/16 :goto_4

    .line 581
    :cond_1
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "notifyStatus"

    new-array v3, v2, [Ljava/lang/Object;

    const-string v4, "status"

    aput-object v4, v3, v5

    invoke-virtual {p0, p1}, Lcom/taobao/accs/net/w;->a(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v6

    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 582
    invoke-direct {p0}, Lcom/taobao/accs/net/w;->v()V

    .line 583
    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/net/f;->d()V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    .line 584
    monitor-enter v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    :try_start_2
    iget-object v1, p0, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    .line 586
    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_1

    .line 589
    :catch_0
    :goto_0
    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 590
    :try_start_4
    iget-object v0, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SPDY_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-static {}, Lcom/taobao/accs/utl/i;->a()Lcom/taobao/accs/utl/i;

    move-result-object v3

    invoke-virtual {v3}, Lcom/taobao/accs/utl/i;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/accs/data/d;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    .line 591
    invoke-virtual {p0, v5, v6}, Lcom/taobao/accs/net/w;->a(ZZ)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    goto :goto_4

    .line 589
    :goto_1
    :try_start_5
    monitor-exit v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :try_start_6
    throw p1

    :cond_2
    iget-object v0, p0, Lcom/taobao/accs/net/w;->n:Ljava/util/concurrent/ScheduledFuture;

    if-eqz v0, :cond_3

    .line 541
    invoke-interface {v0, v6}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    :cond_3
    iget-object v0, p0, Lcom/taobao/accs/net/w;->N:Ljava/lang/String;

    .line 544
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v1

    new-instance v3, Lcom/taobao/accs/net/z;

    invoke-direct {v3, p0, v0}, Lcom/taobao/accs/net/z;-><init>(Lcom/taobao/accs/net/w;Ljava/lang/String;)V

    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/32 v7, 0x1d4c0

    invoke-virtual {v1, v3, v7, v8, v0}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    goto :goto_4

    .line 560
    :cond_4
    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/net/f;->f()V

    .line 561
    invoke-direct {p0}, Lcom/taobao/accs/net/w;->v()V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->n:Ljava/util/concurrent/ScheduledFuture;

    if-eqz v0, :cond_5

    .line 563
    invoke-interface {v0, v6}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    :cond_5
    iget-object v0, p0, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    .line 565
    monitor-enter v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    :try_start_7
    iget-object v1, p0, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    .line 567
    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception p1

    goto :goto_6

    .line 570
    :catch_1
    :goto_2
    :try_start_8
    monitor-exit v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    :try_start_9
    iget-object v0, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 571
    monitor-enter v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    :try_start_a
    iget-object v1, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 573
    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_2
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    goto :goto_3

    :catchall_2
    move-exception p1

    goto :goto_5

    .line 576
    :catch_2
    :goto_3
    :try_start_b
    monitor-exit v0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    .line 596
    :goto_4
    :try_start_c
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "notifyStatus end"

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "status"

    aput-object v3, v2, v5

    invoke-virtual {p0, p1}, Lcom/taobao/accs/net/w;->a(I)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v2, v6

    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    .line 597
    monitor-exit p0

    return-void

    .line 576
    :goto_5
    :try_start_d
    monitor-exit v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_2

    :try_start_e
    throw p1
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_3

    .line 570
    :goto_6
    :try_start_f
    monitor-exit v0
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_1

    :try_start_10
    throw p1
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_3

    :catchall_3
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method static synthetic d(Lcom/taobao/accs/net/w;)Ljava/lang/String;
    .locals 0

    .line 57
    iget-object p0, p0, Lcom/taobao/accs/net/w;->N:Ljava/lang/String;

    return-object p0
.end method

.method private d(Ljava/lang/String;)V
    .locals 16

    move-object/from16 v10, p0

    move-object/from16 v0, p1

    iget v1, v10, Lcom/taobao/accs/net/w;->s:I

    const/4 v2, 0x2

    if-eq v1, v2, :cond_e

    const/4 v3, 0x1

    if-ne v1, v3, :cond_0

    goto/16 :goto_a

    :cond_0
    iget-object v1, v10, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    if-nez v1, :cond_1

    .line 334
    new-instance v1, Lcom/taobao/accs/net/g;

    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Lcom/taobao/accs/net/g;-><init>(Ljava/lang/String;)V

    iput-object v1, v10, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    :cond_1
    iget-object v1, v10, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    .line 336
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Lcom/taobao/accs/net/g;->a(Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    const-wide/16 v4, 0x0

    const/16 v6, 0x1bb

    const-wide/16 v11, 0x0

    const/4 v13, 0x0

    if-eqz v1, :cond_7

    .line 337
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v7

    if-lez v7, :cond_7

    .line 339
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/IConnStrategy;

    if-eqz v1, :cond_2

    .line 341
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v7

    const-string v8, "connect"

    const-string v9, "ip"

    invoke-interface {v1}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v14

    const-string v15, "port"

    invoke-interface {v1}, Lanet/channel/strategy/IConnStrategy;->getPort()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v9, v14, v15, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v7, v8, v1}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_3
    iget-boolean v0, v10, Lcom/taobao/accs/net/w;->L:Z

    if-eqz v0, :cond_4

    iget-object v0, v10, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    .line 345
    invoke-virtual {v0}, Lcom/taobao/accs/net/g;->b()V

    iput-boolean v13, v10, Lcom/taobao/accs/net/w;->L:Z

    :cond_4
    iget-object v0, v10, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    .line 348
    invoke-virtual {v0}, Lcom/taobao/accs/net/g;->a()Lanet/channel/strategy/IConnStrategy;

    move-result-object v0

    if-nez v0, :cond_5

    .line 349
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_5
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v1

    :goto_1
    iput-object v1, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    if-nez v0, :cond_6

    goto :goto_2

    .line 350
    :cond_6
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getPort()I

    move-result v6

    :goto_2
    iput v6, v10, Lcom/taobao/accs/net/w;->p:I

    const-string v0, "accs"

    const-string v1, "dns"

    const-string v6, "httpdns"

    .line 351
    invoke-static {v0, v1, v6, v4, v5}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    .line 352
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "connect from amdc succ"

    const-string v4, "ip"

    iget-object v5, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    const-string v6, "port"

    iget v7, v10, Lcom/taobao/accs/net/w;->p:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    const-string v8, "originPos"

    iget-object v9, v10, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    invoke-virtual {v9}, Lcom/taobao/accs/net/g;->c()I

    move-result v9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    filled-new-array/range {v4 .. v9}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v1, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_4

    :cond_7
    if-eqz v0, :cond_8

    iput-object v0, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    goto :goto_3

    .line 357
    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    .line 360
    :goto_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v7, 0x2

    rem-long/2addr v0, v7

    cmp-long v0, v0, v11

    if-nez v0, :cond_9

    const/16 v6, 0x50

    :cond_9
    iput v6, v10, Lcom/taobao/accs/net/w;->p:I

    const-string v0, "accs"

    const-string v1, "dns"

    const-string v6, "localdns"

    .line 361
    invoke-static {v0, v1, v6, v4, v5}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    .line 362
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "connect get ip from amdc fail!!"

    new-array v4, v13, [Ljava/lang/Object;

    invoke-static {v0, v1, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_4
    iget-object v0, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    .line 364
    invoke-static {v0}, Lcom/taobao/accs/utl/Utils;->isIPV6Address(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 365
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "https://["

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, v10, Lcom/taobao/accs/net/w;->p:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/accs/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v10, Lcom/taobao/accs/net/w;->w:Ljava/lang/String;

    goto :goto_5

    .line 367
    :cond_a
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "https://"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, v10, Lcom/taobao/accs/net/w;->p:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/accs/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v10, Lcom/taobao/accs/net/w;->w:Ljava/lang/String;

    .line 370
    :goto_5
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "connect"

    const-string v4, "URL"

    iget-object v5, v10, Lcom/taobao/accs/net/w;->w:Ljava/lang/String;

    filled-new-array {v4, v5}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v1, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 371
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v10, Lcom/taobao/accs/net/w;->N:Ljava/lang/String;

    iget-object v0, v10, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    if-eqz v0, :cond_b

    .line 375
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v0

    iget-object v1, v10, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    invoke-interface {v0, v1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 377
    :cond_b
    new-instance v0, Lcom/taobao/accs/ut/monitor/SessionMonitor;

    invoke-direct {v0}, Lcom/taobao/accs/ut/monitor/SessionMonitor;-><init>()V

    iput-object v0, v10, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 378
    iget v1, v10, Lcom/taobao/accs/net/w;->c:I

    if-nez v1, :cond_c

    const-string v1, "service"

    goto :goto_6

    :cond_c
    const-string v1, "inapp"

    :goto_6
    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setConnectType(Ljava/lang/String;)V

    iget-object v0, v10, Lcom/taobao/accs/net/w;->y:Lorg/android/spdy/SpdyAgent;

    if-eqz v0, :cond_e

    .line 382
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, v10, Lcom/taobao/accs/net/w;->D:J

    .line 383
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    iput-wide v0, v10, Lcom/taobao/accs/net/w;->E:J

    .line 384
    iget-object v0, v10, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/utl/UtilityImpl;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v10, Lcom/taobao/accs/net/w;->q:Ljava/lang/String;

    .line 385
    iget-object v0, v10, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/utl/UtilityImpl;->b(Landroid/content/Context;)I

    move-result v0

    iput v0, v10, Lcom/taobao/accs/net/w;->r:I

    .line 387
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, v10, Lcom/taobao/accs/net/w;->B:J

    iget-object v0, v10, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 388
    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onStartConnect()V

    .line 389
    invoke-direct {v10, v2}, Lcom/taobao/accs/net/w;->c(I)V

    iget-object v14, v10, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    .line 390
    monitor-enter v14
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v0, v10, Lcom/taobao/accs/net/w;->q:Ljava/lang/String;

    .line 393
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_d

    iget v0, v10, Lcom/taobao/accs/net/w;->r:I

    if-ltz v0, :cond_d

    iget-boolean v0, v10, Lcom/taobao/accs/net/w;->J:Z

    if-eqz v0, :cond_d

    .line 394
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "connect"

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "proxy"

    aput-object v5, v4, v13

    iget-object v5, v10, Lcom/taobao/accs/net/w;->q:Ljava/lang/String;

    aput-object v5, v4, v3

    const-string v3, "port"

    aput-object v3, v4, v2

    iget v2, v10, Lcom/taobao/accs/net/w;->r:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x3

    aput-object v2, v4, v3

    invoke-static {v0, v1, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 395
    new-instance v0, Lorg/android/spdy/SessionInfo;

    iget-object v2, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    iget v3, v10, Lcom/taobao/accs/net/w;->p:I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "_"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v10, Lcom/taobao/accs/net/w;->b:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v5, v10, Lcom/taobao/accs/net/w;->q:Ljava/lang/String;

    iget v6, v10, Lcom/taobao/accs/net/w;->r:I

    iget-object v7, v10, Lcom/taobao/accs/net/w;->N:Ljava/lang/String;

    const/16 v9, 0x1082

    move-object v1, v0

    move-object/from16 v8, p0

    invoke-direct/range {v1 .. v9}, Lorg/android/spdy/SessionInfo;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ILjava/lang/Object;Lorg/android/spdy/SessionCb;I)V

    .line 396
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, v10, Lcom/taobao/accs/net/w;->q:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, v10, Lcom/taobao/accs/net/w;->r:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v10, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    goto :goto_7

    .line 398
    :cond_d
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "connect normal"

    new-array v2, v13, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 399
    new-instance v0, Lorg/android/spdy/SessionInfo;

    iget-object v2, v10, Lcom/taobao/accs/net/w;->o:Ljava/lang/String;

    iget v3, v10, Lcom/taobao/accs/net/w;->p:I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "_"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v10, Lcom/taobao/accs/net/w;->b:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    const/4 v6, 0x0

    iget-object v7, v10, Lcom/taobao/accs/net/w;->N:Ljava/lang/String;

    const/16 v9, 0x1082

    move-object v1, v0

    move-object/from16 v8, p0

    invoke-direct/range {v1 .. v9}, Lorg/android/spdy/SessionInfo;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ILjava/lang/Object;Lorg/android/spdy/SessionCb;I)V

    const-string v1, ""

    iput-object v1, v10, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    .line 402
    :goto_7
    invoke-direct/range {p0 .. p0}, Lcom/taobao/accs/net/w;->t()I

    move-result v1

    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setPubKeySeqNum(I)V

    const v1, 0x9c40

    .line 403
    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setConnectionTimeoutMs(I)V

    iget-object v1, v10, Lcom/taobao/accs/net/w;->y:Lorg/android/spdy/SpdyAgent;

    .line 404
    invoke-virtual {v1, v0}, Lorg/android/spdy/SpdyAgent;->createSession(Lorg/android/spdy/SessionInfo;)Lorg/android/spdy/SpdySession;

    move-result-object v0

    iput-object v0, v10, Lcom/taobao/accs/net/w;->z:Lorg/android/spdy/SpdySession;

    iget-object v0, v10, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 405
    iput-wide v11, v0, Lcom/taobao/accs/ut/monitor/SessionMonitor;->connection_stop_date:J

    iget-object v0, v10, Lcom/taobao/accs/net/w;->A:Ljava/lang/Object;

    .line 406
    invoke-virtual {v0}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_8

    :catchall_0
    move-exception v0

    goto :goto_9

    :catch_0
    move-exception v0

    .line 410
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    iput-boolean v13, v10, Lcom/taobao/accs/net/w;->J:Z

    goto :goto_8

    :catch_1
    move-exception v0

    .line 408
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 413
    :goto_8
    monitor-exit v14

    goto :goto_a

    :goto_9
    monitor-exit v14
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    move-exception v0

    .line 415
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_e
    :goto_a
    return-void
.end method

.method static synthetic e(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/net/g;
    .locals 0

    .line 57
    iget-object p0, p0, Lcom/taobao/accs/net/w;->M:Lcom/taobao/accs/net/g;

    return-object p0
.end method

.method static synthetic f(Lcom/taobao/accs/net/w;)Z
    .locals 0

    .line 57
    iget-boolean p0, p0, Lcom/taobao/accs/net/w;->v:Z

    return p0
.end method

.method static synthetic g(Lcom/taobao/accs/net/w;)J
    .locals 2

    .line 57
    iget-wide v0, p0, Lcom/taobao/accs/net/w;->B:J

    return-wide v0
.end method

.method static synthetic h(Lcom/taobao/accs/net/w;)Lorg/android/spdy/SpdySession;
    .locals 0

    .line 57
    iget-object p0, p0, Lcom/taobao/accs/net/w;->z:Lorg/android/spdy/SpdySession;

    return-object p0
.end method

.method static synthetic i(Lcom/taobao/accs/net/w;)V
    .locals 0

    .line 57
    invoke-direct {p0}, Lcom/taobao/accs/net/w;->v()V

    return-void
.end method

.method private t()I
    .locals 4

    .line 421
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->k()Z

    move-result v0

    .line 423
    sget v1, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    .line 431
    :cond_0
    iget-object v1, p0, Lcom/taobao/accs/net/w;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v1}, Lcom/taobao/accs/AccsClientConfig;->getChannelPubKey()I

    move-result v1

    if-lez v1, :cond_1

    .line 433
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v2, "pubKey"

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "getPublicKeyType use custom pub key"

    invoke-static {v0, v3, v2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return v1

    :cond_1
    if-eqz v0, :cond_2

    const/4 v0, 0x4

    goto :goto_0

    :cond_2
    const/4 v0, 0x3

    :goto_0
    return v0
.end method

.method private u()V
    .locals 11

    const-string v0, "device "

    iget-object v1, p0, Lcom/taobao/accs/net/w;->z:Lorg/android/spdy/SpdySession;

    if-nez v1, :cond_0

    const/4 v0, 0x3

    .line 448
    invoke-direct {p0, v0}, Lcom/taobao/accs/net/w;->c(I)V

    return-void

    :cond_0
    const/4 v1, 0x0

    .line 452
    :try_start_0
    iget-object v2, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v2}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 453
    invoke-static {v2}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 454
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->i()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/taobao/accs/net/w;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v4}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    .line 455
    invoke-static {v5}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v5

    .line 454
    invoke-static {v3, v4, v5}, Lcom/taobao/accs/utl/UtilityImpl;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/taobao/accs/net/w;->w:Ljava/lang/String;

    .line 457
    invoke-virtual {p0, v4}, Lcom/taobao/accs/net/w;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 458
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v5

    const-string v6, "auth"

    const/4 v7, 0x2

    new-array v8, v7, [Ljava/lang/Object;

    const-string v9, "url"

    aput-object v9, v8, v1

    const/4 v9, 0x1

    aput-object v4, v8, v9

    invoke-static {v5, v6, v8}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iput-object v4, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    .line 461
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->i()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v2, v5, v3}, Lcom/taobao/accs/net/w;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 462
    sget-object v4, Lcom/taobao/accs/AccsErrorCode;->SPDY_AUTH_PARAM_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " key "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->i()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " sign "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    .line 463
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v2

    const-string v3, "auth param error!"

    new-array v4, v7, [Ljava/lang/Object;

    const-string v5, "code"

    aput-object v5, v4, v1

    aput-object v0, v4, v9

    invoke-static {v2, v3, v4}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 464
    invoke-direct {p0, v0}, Lcom/taobao/accs/net/w;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    return-void

    .line 468
    :cond_1
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 469
    new-instance v0, Lorg/android/spdy/SpdyRequest;

    new-instance v6, Ljava/net/URL;

    invoke-direct {v6, v4}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    const-string v7, "GET"

    sget-object v8, Lorg/android/spdy/RequestPriority;->DEFAULT_PRIORITY:Lorg/android/spdy/RequestPriority;

    const v9, 0x13880

    const v10, 0x9c40

    move-object v5, v0

    invoke-direct/range {v5 .. v10}, Lorg/android/spdy/SpdyRequest;-><init>(Ljava/net/URL;Ljava/lang/String;Lorg/android/spdy/RequestPriority;II)V

    .line 474
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lorg/android/spdy/SpdyRequest;->setDomain(Ljava/lang/String;)V

    .line 475
    new-instance v2, Lorg/android/spdy/SpdyDataProvider;

    const/4 v3, 0x0

    move-object v4, v3

    check-cast v4, [B

    invoke-direct {v2, v3}, Lorg/android/spdy/SpdyDataProvider;-><init>([B)V

    iget-object v3, p0, Lcom/taobao/accs/net/w;->z:Lorg/android/spdy/SpdySession;

    .line 476
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v0, v2, v4, p0}, Lorg/android/spdy/SpdySession;->submitRequest(Lorg/android/spdy/SpdyRequest;Lorg/android/spdy/SpdyDataProvider;Ljava/lang/Object;Lorg/android/spdy/Spdycb;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    .line 478
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v2

    const-string v3, "auth exception "

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 479
    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SPDY_AUTH_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->getExceptionInfo(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/taobao/accs/net/w;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    :goto_0
    return-void
.end method

.method private declared-synchronized v()V
    .locals 2

    monitor-enter p0

    .line 522
    :try_start_0
    iget v0, p0, Lcom/taobao/accs/net/w;->c:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 523
    monitor-exit p0

    return-void

    .line 525
    :cond_0
    :try_start_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/accs/net/w;->B:J

    .line 526
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/accs/net/w;->C:J

    .line 527
    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/net/f;->a()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 528
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method private w()V
    .locals 7

    const-string v0, "initClient"

    const-string v1, "config tnet log path:"

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 607
    :try_start_0
    sput-boolean v2, Lorg/android/spdy/SpdyAgent;->enableDebug:Z

    .line 608
    iget-object v2, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    sget-object v4, Lorg/android/spdy/SpdyVersion;->SPDY3:Lorg/android/spdy/SpdyVersion;

    sget-object v5, Lorg/android/spdy/SpdySessionKind;->NONE_SESSION:Lorg/android/spdy/SpdySessionKind;

    invoke-static {v2, v4, v5}, Lorg/android/spdy/SpdyAgent;->getInstance(Landroid/content/Context;Lorg/android/spdy/SpdyVersion;Lorg/android/spdy/SpdySessionKind;)Lorg/android/spdy/SpdyAgent;

    move-result-object v2

    iput-object v2, p0, Lcom/taobao/accs/net/w;->y:Lorg/android/spdy/SpdyAgent;

    .line 610
    invoke-static {}, Lorg/android/spdy/SpdyAgent;->checkLoadSucc()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 612
    invoke-static {}, Lcom/taobao/accs/utl/f;->a()V

    .line 613
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->k()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/taobao/accs/net/w;->y:Lorg/android/spdy/SpdyAgent;

    .line 614
    new-instance v4, Lcom/taobao/accs/net/aa;

    invoke-direct {v4, p0}, Lcom/taobao/accs/net/aa;-><init>(Lcom/taobao/accs/net/w;)V

    invoke-virtual {v2, v4}, Lorg/android/spdy/SpdyAgent;->setAccsSslCallback(Lorg/android/spdy/AccsSSLCallback;)V

    .line 621
    :cond_0
    invoke-static {v3}, Lcom/taobao/accs/utl/OrangeAdapter;->isTnetLogOff(Z)Z

    move-result v2

    if-nez v2, :cond_3

    .line 623
    iget v2, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez v2, :cond_1

    const-string v2, "service"

    goto :goto_0

    :cond_1
    const-string v2, "inapp"

    .line 624
    :goto_0
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v4

    const-string v5, "into--[setTnetLogPath]"

    new-array v6, v3, [Ljava/lang/Object;

    invoke-static {v4, v5, v6}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 625
    iget-object v4, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v4, v2}, Lcom/taobao/accs/utl/UtilityImpl;->d(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 626
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v5, v3, [Ljava/lang/Object;

    invoke-static {v4, v1, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 627
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    iget-object v1, p0, Lcom/taobao/accs/net/w;->y:Lorg/android/spdy/SpdyAgent;

    const/high16 v4, 0x500000

    const/4 v5, 0x5

    .line 628
    invoke-virtual {v1, v2, v4, v5}, Lorg/android/spdy/SpdyAgent;->configLogFile(Ljava/lang/String;II)I

    goto :goto_1

    .line 632
    :cond_2
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 633
    invoke-static {}, Lcom/taobao/accs/utl/f;->b()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v1

    .line 636
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v2

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_3
    :goto_1
    return-void
.end method


# virtual methods
.method public a()V
    .locals 4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/accs/net/w;->v:Z

    .line 137
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    const-string v3, "start"

    invoke-static {v0, v3, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 138
    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/taobao/accs/net/w;->a(Landroid/content/Context;)V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->u:Lcom/taobao/accs/net/w$a;

    if-nez v0, :cond_0

    .line 140
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v2, "start thread"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    new-instance v0, Lcom/taobao/accs/net/w$a;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "NetworkThread_"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/taobao/accs/net/w;->m:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, p0, v2}, Lcom/taobao/accs/net/w$a;-><init>(Lcom/taobao/accs/net/w;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/taobao/accs/net/w;->u:Lcom/taobao/accs/net/w$a;

    const/4 v2, 0x2

    .line 142
    invoke-virtual {v0, v2}, Lcom/taobao/accs/net/w$a;->setPriority(I)V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->u:Lcom/taobao/accs/net/w$a;

    .line 143
    invoke-virtual {v0}, Lcom/taobao/accs/net/w$a;->start()V

    .line 145
    :cond_0
    invoke-virtual {p0, v1, v1}, Lcom/taobao/accs/net/w;->a(ZZ)V

    return-void
.end method

.method protected a(Landroid/content/Context;)V
    .locals 2

    .line 1137
    iget-boolean v0, p0, Lcom/taobao/accs/net/w;->g:Z

    if-eqz v0, :cond_0

    return-void

    .line 1140
    :cond_0
    invoke-super {p0, p1}, Lcom/taobao/accs/net/b;->a(Landroid/content/Context;)V

    const/4 p1, 0x0

    .line 1141
    invoke-static {p1}, Lanet/channel/GlobalAppRuntimeInfo;->setBackground(Z)V

    const/4 v0, 0x1

    .line 1142
    iput-boolean v0, p0, Lcom/taobao/accs/net/w;->g:Z

    .line 1143
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "init awcn success!"

    new-array p1, p1, [Ljava/lang/Object;

    invoke-static {v0, v1, p1}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method protected a(Lcom/taobao/accs/data/Message;Z)V
    .locals 5

    iget-boolean v0, p0, Lcom/taobao/accs/net/w;->v:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_5

    if-nez p1, :cond_0

    goto/16 :goto_1

    .line 154
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->size()I

    move-result v0

    const/16 v2, 0x3e8

    if-gt v0, v2, :cond_3

    .line 158
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v2, Lcom/taobao/accs/net/x;

    invoke-direct {v2, p0, p1, p2}, Lcom/taobao/accs/net/x;-><init>(Lcom/taobao/accs/net/w;Lcom/taobao/accs/data/Message;Z)V

    iget-wide v3, p1, Lcom/taobao/accs/data/Message;->Q:J

    sget-object p2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v2, v3, v4, p2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p2

    .line 196
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->a()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_2

    iget-object v0, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 199
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 200
    iget-object v0, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/taobao/accs/net/w;->a(Ljava/lang/String;)Z

    .line 202
    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    iget-object v0, v0, Lcom/taobao/accs/data/d;->a:Ljava/util/concurrent/ConcurrentMap;

    iget-object v2, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-interface {v0, v2, p2}, Ljava/util/concurrent/ConcurrentMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 205
    :cond_2
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p2

    if-eqz p2, :cond_4

    .line 206
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p2

    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setDeviceId(Ljava/lang/String;)V

    .line 207
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p2

    iget v0, p0, Lcom/taobao/accs/net/w;->c:I

    invoke-virtual {p2, v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setConnType(I)V

    .line 208
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onEnterQueueData()V

    goto :goto_0

    .line 155
    :cond_3
    new-instance p2, Ljava/util/concurrent/RejectedExecutionException;

    const-string v0, "accs"

    invoke-direct {p2, v0}, Ljava/util/concurrent/RejectedExecutionException;-><init>(Ljava/lang/String;)V

    throw p2
    :try_end_0
    .catch Ljava/util/concurrent/RejectedExecutionException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    move-exception p2

    .line 216
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v2, "send error"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, p2, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 217
    iget-object v0, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SEND_LOCAL_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-static {p2}, Lcom/taobao/accs/AccsErrorCode;->getExceptionInfo(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto :goto_0

    .line 212
    :catch_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object p2

    invoke-virtual {p2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/concurrent/BlockingQueue;->size()I

    move-result p2

    .line 213
    iget-object v0, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_QUEUE_FULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "channel "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v2

    invoke-virtual {v0, p1, v2}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    .line 214
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "send queue full count:"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p1, p2, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    :goto_0
    return-void

    .line 150
    :cond_5
    :goto_1
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "not running or msg null! "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/taobao/accs/net/w;->v:Z

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p1, p2, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method protected a(Ljava/lang/String;ZLjava/lang/String;)V
    .locals 0

    const/4 p1, 0x4

    .line 1071
    :try_start_0
    invoke-direct {p0, p1}, Lcom/taobao/accs/net/w;->c(I)V

    .line 1072
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->q()V

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 1073
    invoke-virtual {p1, p3}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 1075
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public a(ZZ)V
    .locals 4

    .line 245
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "try ping, force:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 246
    iget v0, p0, Lcom/taobao/accs/net/w;->c:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 247
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const-string p2, "INAPP, skip"

    new-array v0, v2, [Ljava/lang/Object;

    invoke-static {p1, p2, v0}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_0
    if-eqz p2, :cond_1

    .line 250
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v0

    const-wide/high16 v2, 0x4024000000000000L    # 10.0

    mul-double/2addr v0, v2

    const-wide v2, 0x408f400000000000L    # 1000.0

    mul-double/2addr v0, v2

    goto :goto_0

    :cond_1
    const-wide/16 v0, 0x0

    :goto_0
    double-to-int p2, v0

    invoke-static {p1, p2}, Lcom/taobao/accs/data/Message;->a(ZI)Lcom/taobao/accs/data/Message;

    move-result-object p2

    invoke-virtual {p0, p2, p1}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/data/Message;Z)V

    return-void
.end method

.method public a(Ljava/lang/String;)Z
    .locals 5

    iget-object v0, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 1087
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 1088
    invoke-virtual {v1}, Ljava/util/LinkedList;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    :goto_0
    if-ltz v1, :cond_1

    iget-object v3, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 1089
    invoke-virtual {v3, v1}, Ljava/util/LinkedList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/taobao/accs/data/Message;

    if-eqz v3, :cond_0

    .line 1091
    invoke-virtual {v3}, Lcom/taobao/accs/data/Message;->a()I

    move-result v4

    if-ne v4, v2, :cond_0

    iget-object v4, v3, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    if-eqz v4, :cond_0

    iget-object v3, v3, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    .line 1093
    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 1094
    invoke-virtual {p1, v1}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :cond_0
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    .line 1099
    :goto_1
    monitor-exit v0

    return v2

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public b(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 1148
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "https://"

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getChannelHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public b()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/net/w;->J:Z

    .line 1060
    iput v0, p0, Lcom/taobao/accs/net/w;->f:I

    return-void
.end method

.method public bioPingRecvCallback(Lorg/android/spdy/SpdySession;I)V
    .locals 2

    .line 1065
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "bioPingRecvCallback uniId:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p1, p2, v0}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public c()Lcom/taobao/accs/ut/a/c;
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    if-nez v0, :cond_0

    .line 271
    new-instance v0, Lcom/taobao/accs/ut/a/c;

    invoke-direct {v0}, Lcom/taobao/accs/ut/a/c;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    .line 273
    iget v1, p0, Lcom/taobao/accs/net/w;->c:I

    iput v1, v0, Lcom/taobao/accs/ut/a/c;->b:I

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->t:Ljava/util/LinkedList;

    .line 274
    invoke-virtual {v1}, Ljava/util/LinkedList;->size()I

    move-result v1

    iput v1, v0, Lcom/taobao/accs/ut/a/c;->d:I

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    .line 275
    iget-object v1, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v1}, Lcom/taobao/accs/utl/UtilityImpl;->g(Landroid/content/Context;)Z

    move-result v1

    iput-boolean v1, v0, Lcom/taobao/accs/ut/a/c;->i:Z

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    .line 276
    iput-object v1, v0, Lcom/taobao/accs/ut/a/c;->f:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    iget v1, p0, Lcom/taobao/accs/net/w;->s:I

    .line 277
    iput v1, v0, Lcom/taobao/accs/ut/a/c;->a:I

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 278
    invoke-virtual {v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->getRet()Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    :cond_1
    move v1, v2

    :goto_0
    iput-boolean v1, v0, Lcom/taobao/accs/ut/a/c;->c:Z

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    .line 279
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->s()Z

    move-result v1

    iput-boolean v1, v0, Lcom/taobao/accs/ut/a/c;->j:Z

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    .line 280
    iget-object v1, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    iget-object v1, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v1}, Lcom/taobao/accs/data/d;->d()I

    move-result v2

    :goto_1
    iput v2, v0, Lcom/taobao/accs/ut/a/c;->e:I

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    .line 281
    iput-object v1, v0, Lcom/taobao/accs/ut/a/c;->g:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/accs/net/w;->I:Lcom/taobao/accs/ut/a/c;

    return-object v0
.end method

.method protected d()Ljava/lang/String;
    .locals 2

    .line 1123
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "SilenceConn_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/accs/net/w;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public e()V
    .locals 3

    .line 223
    invoke-super {p0}, Lcom/taobao/accs/net/b;->e()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/net/w;->v:Z

    .line 225
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v1

    new-instance v2, Lcom/taobao/accs/net/y;

    invoke-direct {v2, p0}, Lcom/taobao/accs/net/y;-><init>(Lcom/taobao/accs/net/w;)V

    invoke-virtual {v1, v2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    .line 240
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v1

    const-string v2, "shut down"

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v1, v2, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public getSSLMeta(Lorg/android/spdy/SpdySession;)[B
    .locals 2

    .line 1106
    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->b:Ljava/lang/String;

    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->getDomain()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1}, Lcom/taobao/accs/utl/UtilityImpl;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object p1

    return-object p1
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public l()Z
    .locals 2

    iget v0, p0, Lcom/taobao/accs/net/w;->s:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public m()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public n()V
    .locals 0

    .line 1166
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->q()V

    return-void
.end method

.method public o()V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 1171
    invoke-virtual {p0, v0, v1}, Lcom/taobao/accs/net/w;->a(ZZ)V

    return-void
.end method

.method public putSSLMeta(Lorg/android/spdy/SpdySession;[B)I
    .locals 2

    .line 1111
    iget-object v0, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    iget-object v1, p0, Lcom/taobao/accs/net/w;->b:Ljava/lang/String;

    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->getDomain()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1, p2}, Lcom/taobao/accs/utl/UtilityImpl;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[B)I

    move-result p1

    return p1
.end method

.method public q()V
    .locals 3

    .line 260
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, " force close!"

    invoke-static {v0, v2, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/net/w;->z:Lorg/android/spdy/SpdySession;

    .line 262
    invoke-virtual {v0}, Lorg/android/spdy/SpdySession;->closeSession()I

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    const/4 v1, 0x1

    .line 263
    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseType(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 v0, 0x3

    .line 266
    invoke-direct {p0, v0}, Lcom/taobao/accs/net/w;->c(I)V

    return-void
.end method

.method public r()Ljava/lang/String;
    .locals 4

    .line 600
    iget-object v0, p0, Lcom/taobao/accs/net/w;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getChannelHost()Ljava/lang/String;

    move-result-object v0

    .line 601
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v1

    const-string v2, "host"

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "getChannelHost"

    invoke-static {v1, v3, v2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    return-object v0
.end method

.method public s()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/accs/net/w;->v:Z

    return v0
.end method

.method public spdyCustomControlFrameFailCallback(Lorg/android/spdy/SpdySession;Ljava/lang/Object;II)V
    .locals 0

    .line 1129
    invoke-virtual {p0, p3}, Lcom/taobao/accs/net/w;->b(I)V

    return-void
.end method

.method public spdyCustomControlFrameRecvCallback(Lorg/android/spdy/SpdySession;Ljava/lang/Object;IIII[B)V
    .locals 4

    .line 939
    invoke-direct {p0}, Lcom/taobao/accs/net/w;->v()V

    .line 941
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    array-length p3, p7

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const-string p5, "type"

    const-string p6, "len"

    filled-new-array {p5, p2, p6, p3}, [Ljava/lang/Object;

    move-result-object p2

    const-string p3, "onFrame"

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 943
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    .line 945
    sget-object p2, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {p2}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result p2

    const/4 p3, 0x0

    if-eqz p2, :cond_1

    .line 946
    array-length p2, p7

    const/16 p5, 0x200

    if-ge p2, p5, :cond_1

    .line 947
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    move p2, p3

    .line 948
    :goto_0
    array-length p5, p7

    if-ge p2, p5, :cond_0

    .line 949
    aget-byte p5, p7, p2

    and-int/lit16 p5, p5, 0xff

    invoke-static {p5}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p1, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p5

    const-string v2, " "

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 951
    :cond_0
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p2

    new-instance p5, Ljava/lang/StringBuilder;

    invoke-direct {p5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p5, " log time:"

    invoke-virtual {p1, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long/2addr v2, v0

    invoke-virtual {p1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-array p5, p3, [Ljava/lang/Object;

    invoke-static {p2, p1, p5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    const/16 p1, 0xc8

    if-ne p4, p1, :cond_4

    .line 958
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    .line 959
    iget-object p4, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {p4, p7}, Lcom/taobao/accs/data/d;->a([B)V

    .line 960
    iget-object p4, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {p4}, Lcom/taobao/accs/data/d;->g()Lcom/taobao/accs/ut/a/d;

    move-result-object p4

    if-eqz p4, :cond_3

    .line 962
    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p4, Lcom/taobao/accs/ut/a/d;->c:Ljava/lang/String;

    .line 963
    iget p1, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez p1, :cond_2

    const-string p1, "service"

    goto :goto_1

    :cond_2
    const-string p1, "inapp"

    :goto_1
    iput-object p1, p4, Lcom/taobao/accs/ut/a/d;->g:Ljava/lang/String;

    .line 964
    invoke-virtual {p4}, Lcom/taobao/accs/ut/a/d;->a()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p1

    .line 967
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p2

    const-string p4, "onDataReceive "

    new-array p5, p3, [Ljava/lang/Object;

    invoke-static {p2, p4, p1, p5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 968
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object p2

    const-string p4, "SERVICE_DATA_RECEIVE"

    invoke-static {p1}, Lcom/taobao/accs/utl/UtilityImpl;->a(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    const p5, 0x101d1

    invoke-virtual {p2, p5, p4, p1}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;)V

    .line 970
    :cond_3
    :goto_2
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const-string p2, "try handle msg"

    new-array p4, p3, [Ljava/lang/Object;

    invoke-static {p1, p2, p4}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 971
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->g()V

    goto :goto_3

    .line 973
    :cond_4
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    array-length p2, p7

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    filled-new-array {p6, p2}, [Ljava/lang/Object;

    move-result-object p2

    const-string p4, "drop frame"

    invoke-static {p1, p4, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 975
    :goto_3
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const-string p2, "spdyCustomControlFrameRecvCallback"

    new-array p3, p3, [Ljava/lang/Object;

    invoke-static {p1, p2, p3}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public spdyDataChunkRecvCB(Lorg/android/spdy/SpdySession;ZJLorg/android/spdy/SpdyByteArray;Ljava/lang/Object;)V
    .locals 0

    .line 1117
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string p3, "spdyDataChunkRecvCB"

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public spdyDataRecvCallback(Lorg/android/spdy/SpdySession;ZJILjava/lang/Object;)V
    .locals 0

    .line 1053
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string p3, "spdyDataRecvCallback"

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public spdyDataSendCallback(Lorg/android/spdy/SpdySession;ZJILjava/lang/Object;)V
    .locals 0

    .line 1047
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string p3, "spdyDataSendCallback"

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public spdyOnStreamResponse(Lorg/android/spdy/SpdySession;JLjava/util/Map;Ljava/lang/Object;)V
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/android/spdy/SpdySession;",
            "J",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;",
            "Ljava/lang/Object;",
            ")V"
        }
    .end annotation

    move-object/from16 v1, p0

    const-string v2, "spdyOnStreamResponse"

    const-string v0, "CONNECTED 200 "

    const-string v3, "channel code "

    .line 997
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v1, Lcom/taobao/accs/net/w;->B:J

    .line 998
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v4

    iput-wide v4, v1, Lcom/taobao/accs/net/w;->C:J

    const/4 v4, 0x0

    .line 1000
    :try_start_0
    invoke-static/range {p4 .. p4}, Lcom/taobao/accs/utl/UtilityImpl;->a(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v5

    const-string v6, "SilenceConn_"

    const/4 v7, 0x2

    new-array v8, v7, [Ljava/lang/Object;

    const-string v9, "header"

    aput-object v9, v8, v4

    const/4 v9, 0x1

    aput-object p4, v8, v9

    .line 1001
    invoke-static {v6, v2, v8}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v6, ":status"

    .line 1002
    invoke-interface {v5, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/16 v8, 0xc8

    const-string v10, "httpStatusCode"

    if-ne v6, v8, :cond_3

    .line 1004
    :try_start_1
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v3

    new-array v7, v7, [Ljava/lang/Object;

    aput-object v10, v7, v4

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v7, v9

    invoke-static {v3, v2, v7}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1005
    invoke-direct {v1, v9}, Lcom/taobao/accs/net/w;->c(I)V

    const-string v3, "x-at"

    .line 1006
    invoke-interface {v5, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 1007
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 1008
    iput-object v3, v1, Lcom/taobao/accs/net/w;->k:Ljava/lang/String;

    :cond_0
    iget-object v3, v1, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 1012
    iget-wide v5, v3, Lcom/taobao/accs/ut/monitor/SessionMonitor;->connection_stop_date:J

    const-wide/16 v7, 0x0

    cmp-long v5, v5, v7

    if-lez v5, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    iget-object v7, v1, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    iget-wide v7, v7, Lcom/taobao/accs/ut/monitor/SessionMonitor;->connection_stop_date:J

    sub-long v7, v5, v7

    :cond_1
    iput-wide v7, v3, Lcom/taobao/accs/ut/monitor/SessionMonitor;->auth_time:J

    .line 1013
    iget v3, v1, Lcom/taobao/accs/net/w;->c:I

    if-nez v3, :cond_2

    const-string v3, "service"

    goto :goto_0

    :cond_2
    const-string v3, "inapp"

    .line 1014
    :goto_0
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v10

    const v11, 0x101d1

    invoke-virtual {v0, v3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    iget-object v13, v1, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    iget-object v14, v1, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    const/16 v0, 0xde

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    new-array v0, v9, [Ljava/lang/String;

    const-string v3, "0"

    aput-object v3, v0, v4

    move-object/from16 v16, v0

    invoke-virtual/range {v10 .. v16}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/String;)V

    const-string v0, "accs"

    const-string v3, "auth"

    const-string v5, ""

    .line 1015
    invoke-static {v0, v3, v5}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmSuccess(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 1017
    :cond_3
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    new-array v5, v7, [Ljava/lang/Object;

    aput-object v10, v5, v4

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v5, v9

    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1018
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORKSDK_SPDY_RES_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/taobao/accs/net/w;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 1022
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v3, v0, v5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1023
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, v1, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    const-string v3, "exception"

    .line 1024
    invoke-virtual {v0, v3}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    .line 1026
    :goto_1
    invoke-virtual/range {p0 .. p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public spdyPingRecvCallback(Lorg/android/spdy/SpdySession;JLjava/lang/Object;)V
    .locals 2

    .line 921
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Ljava/lang/StringBuilder;

    const-string v0, "spdyPingRecvCallback uniId:"

    invoke-direct {p4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p4, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p1, p4, v0}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-wide/16 v0, 0x0

    cmp-long p1, p2, v0

    if-gez p1, :cond_0

    return-void

    .line 925
    :cond_0
    iget-object p1, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {p1}, Lcom/taobao/accs/data/d;->b()V

    .line 926
    iget-object p1, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {p1}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/accs/net/f;->e()V

    .line 927
    iget-object p1, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {p1}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/accs/net/f;->a()V

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 928
    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onPingCBReceive()V

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 930
    iget p1, p1, Lcom/taobao/accs/ut/monitor/SessionMonitor;->ping_rec_times:I

    rem-int/lit8 p1, p1, 0x2

    if-nez p1, :cond_1

    .line 931
    iget-object p1, p0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    const-string p2, "service_end"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p3

    invoke-static {p1, p2, p3, p4}, Lcom/taobao/accs/utl/UtilityImpl;->a(Landroid/content/Context;Ljava/lang/String;J)V

    :cond_1
    return-void
.end method

.method public spdyRequestRecvCallback(Lorg/android/spdy/SpdySession;JLjava/lang/Object;)V
    .locals 0

    .line 991
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string p3, "spdyRequestRecvCallback"

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public spdySessionCloseCallback(Lorg/android/spdy/SpdySession;Ljava/lang/Object;Lorg/android/spdy/SuperviseConnectInfo;I)V
    .locals 8

    .line 880
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p2

    const-string v0, "errorCode"

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "spdySessionCloseCallback"

    invoke-static {p2, v1, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p2, 0x0

    if-eqz p1, :cond_0

    .line 883
    :try_start_0
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->cleanUp()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 886
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "session cleanUp has exception: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-array v1, p2, [Ljava/lang/Object;

    invoke-static {v0, p1, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    const/4 p1, 0x3

    .line 889
    invoke-direct {p0, p1}, Lcom/taobao/accs/net/w;->c(I)V

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 893
    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onCloseConnect()V

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 894
    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->getConCloseDate()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-lez p1, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->getConStopDate()J

    move-result-wide v0

    cmp-long p1, v0, v2

    if-lez p1, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 895
    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->getConCloseDate()J

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    invoke-virtual {p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->getConStopDate()J

    .line 898
    :cond_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->getCloseReason()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "tnet error:"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 899
    invoke-virtual {v0, p1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    if-eqz p3, :cond_2

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 901
    iget p3, p3, Lorg/android/spdy/SuperviseConnectInfo;->keepalive_period_second:I

    int-to-long v0, p3

    iput-wide v0, p1, Lcom/taobao/accs/ut/monitor/SessionMonitor;->live_time:J

    .line 903
    :cond_2
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object p3, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    invoke-interface {p1, p3}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 905
    iget-object p1, p0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {p1}, Lcom/taobao/accs/data/d;->e()Ljava/util/Collection;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_3
    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lcom/taobao/accs/data/Message;

    .line 906
    invoke-virtual {p3}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 907
    invoke-virtual {p3}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v0

    const-string v1, "session close"

    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setFailReason(Ljava/lang/String;)V

    .line 908
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v0

    invoke-virtual {p3}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p3

    invoke-interface {v0, p3}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    goto :goto_1

    .line 912
    :cond_4
    iget p1, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez p1, :cond_5

    const-string p1, "service"

    goto :goto_2

    :cond_5
    const-string p1, "inapp"

    .line 913
    :goto_2
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p3

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "spdySessionCloseCallback, conKeepTime:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    iget-wide v1, v1, Lcom/taobao/accs/ut/monitor/SessionMonitor;->live_time:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " connectType:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array p2, p2, [Ljava/lang/Object;

    invoke-static {p3, v0, p2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 914
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v1

    const v2, 0x101d1

    const-string p2, "DISCONNECT CLOSE "

    invoke-virtual {p2, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    iget-object p1, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    iget-wide p1, p1, Lcom/taobao/accs/ut/monitor/SessionMonitor;->live_time:J

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    const/16 p1, 0xde

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    iget-object p1, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    iget-object p2, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    filled-new-array {p1, p2}, [Ljava/lang/String;

    move-result-object v7

    invoke-virtual/range {v1 .. v7}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/String;)V

    return-void
.end method

.method public spdySessionConnectCB(Lorg/android/spdy/SpdySession;Lorg/android/spdy/SuperviseConnectInfo;)V
    .locals 8

    .line 864
    iget p1, p2, Lorg/android/spdy/SuperviseConnectInfo;->connectTime:I

    iput p1, p0, Lcom/taobao/accs/net/w;->F:I

    .line 865
    iget p1, p2, Lorg/android/spdy/SuperviseConnectInfo;->handshakeTime:I

    .line 866
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    const-string v1, "sessionConnectInterval"

    iget v2, p0, Lcom/taobao/accs/net/w;->F:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "sslTime"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const-string v5, "reuse"

    iget v6, p2, Lorg/android/spdy/SuperviseConnectInfo;->sessionTicketReused:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "spdySessionConnectCB"

    invoke-static {v0, v2, v1}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 867
    invoke-direct {p0}, Lcom/taobao/accs/net/w;->u()V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    const/4 v1, 0x1

    .line 868
    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setRet(Z)V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 869
    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onConnectStop()V

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    iget v1, p0, Lcom/taobao/accs/net/w;->F:I

    int-to-long v1, v1

    .line 870
    iput-wide v1, v0, Lcom/taobao/accs/ut/monitor/SessionMonitor;->tcp_time:J

    iget-object v0, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    int-to-long v1, p1

    .line 871
    iput-wide v1, v0, Lcom/taobao/accs/ut/monitor/SessionMonitor;->ssl_time:J

    .line 872
    iget v0, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez v0, :cond_0

    const-string v0, "service"

    goto :goto_0

    :cond_0
    const-string v0, "inapp"

    .line 873
    :goto_0
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v1

    const v2, 0x101d1

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "CONNECTED "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v3, p2, Lorg/android/spdy/SuperviseConnectInfo;->sessionTicketReused:I

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iget v0, p0, Lcom/taobao/accs/net/w;->F:I

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    const/16 p1, 0xde

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    iget p1, p2, Lorg/android/spdy/SuperviseConnectInfo;->sessionTicketReused:I

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    filled-new-array {p1, p2, v0}, [Ljava/lang/String;

    move-result-object v7

    invoke-virtual/range {v1 .. v7}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/String;)V

    const-string p1, "connect"

    const-string p2, ""

    const-string v0, "accs"

    .line 874
    invoke-static {v0, p1, p2}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmSuccess(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public spdySessionFailedError(Lorg/android/spdy/SpdySession;ILjava/lang/Object;)V
    .locals 7

    const/4 p3, 0x0

    if-eqz p1, :cond_0

    .line 840
    :try_start_0
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->cleanUp()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 843
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "session cleanUp has exception: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-array v1, p3, [Ljava/lang/Object;

    invoke-static {v0, p1, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    iget-object p1, p0, Lcom/taobao/accs/net/w;->u:Lcom/taobao/accs/net/w$a;

    if-eqz p1, :cond_1

    .line 847
    iget p1, p1, Lcom/taobao/accs/net/w$a;->a:I

    goto :goto_1

    :cond_1
    move p1, p3

    .line 849
    :goto_1
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errorId"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "retryTimes"

    filled-new-array {v4, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "spdySessionFailedError"

    invoke-static {v0, v2, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iput-boolean p3, p0, Lcom/taobao/accs/net/w;->J:Z

    const/4 p3, 0x1

    iput-boolean p3, p0, Lcom/taobao/accs/net/w;->L:Z

    const/4 p3, 0x3

    .line 852
    invoke-direct {p0, p3}, Lcom/taobao/accs/net/w;->c(I)V

    iget-object p3, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 853
    invoke-virtual {p3, p2}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setFailReason(I)V

    iget-object p3, p0, Lcom/taobao/accs/net/w;->H:Lcom/taobao/accs/ut/monitor/SessionMonitor;

    .line 854
    invoke-virtual {p3}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onConnectStop()V

    .line 855
    iget p3, p0, Lcom/taobao/accs/net/w;->c:I

    if-nez p3, :cond_2

    const-string p3, "service"

    goto :goto_2

    :cond_2
    const-string p3, "inapp"

    .line 856
    :goto_2
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v0

    const v1, 0x101d1

    const-string v2, "DISCONNECT "

    invoke-virtual {v2, p3}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/16 p3, 0xde

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    iget-object p3, p0, Lcom/taobao/accs/net/w;->x:Ljava/lang/String;

    iget-object v6, p0, Lcom/taobao/accs/net/w;->K:Ljava/lang/String;

    filled-new-array {p3, v6}, [Ljava/lang/String;

    move-result-object v6

    invoke-virtual/range {v0 .. v6}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/String;)V

    .line 857
    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "retrytimes:"

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, ""

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string v0, "accs"

    const-string v1, "connect"

    invoke-static {v0, v1, p1, p2, p3}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public spdyStreamCloseCallback(Lorg/android/spdy/SpdySession;JILjava/lang/Object;Lorg/android/spdy/SuperviseData;)V
    .locals 0

    .line 981
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string p3, "spdyStreamCloseCallback"

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p4, :cond_0

    .line 983
    invoke-virtual {p0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object p1

    const-string p2, "statusCode"

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p5

    filled-new-array {p2, p5}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p1, p3, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 984
    sget-object p1, Lcom/taobao/accs/AccsErrorCode;->NETWORKSDK_SPDY_CLOSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string p3, "channel code "

    invoke-direct {p2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/taobao/accs/net/w;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    :cond_0
    return-void
.end method
