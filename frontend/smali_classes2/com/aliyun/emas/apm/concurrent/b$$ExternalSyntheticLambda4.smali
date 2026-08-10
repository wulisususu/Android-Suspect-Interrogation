.class public final synthetic Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/concurrent/c$c;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/concurrent/b;

.field public final synthetic f$1:Ljava/lang/Runnable;

.field public final synthetic f$2:J

.field public final synthetic f$3:J

.field public final synthetic f$4:Ljava/util/concurrent/TimeUnit;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/concurrent/b;Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$1:Ljava/lang/Runnable;

    iput-wide p3, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$2:J

    iput-wide p5, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$3:J

    iput-object p7, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$4:Ljava/util/concurrent/TimeUnit;

    return-void
.end method


# virtual methods
.method public final a(Lcom/aliyun/emas/apm/concurrent/c$b;)Ljava/util/concurrent/ScheduledFuture;
    .locals 8

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$1:Ljava/lang/Runnable;

    iget-wide v2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$2:J

    iget-wide v4, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$3:J

    iget-object v6, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda4;->f$4:Ljava/util/concurrent/TimeUnit;

    move-object v7, p1

    invoke-static/range {v0 .. v7}, Lcom/aliyun/emas/apm/concurrent/b;->$r8$lambda$iEsODsa1lVy2x8-v34K3RYloqUo(Lcom/aliyun/emas/apm/concurrent/b;Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;Lcom/aliyun/emas/apm/concurrent/c$b;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p1

    return-object p1
.end method
