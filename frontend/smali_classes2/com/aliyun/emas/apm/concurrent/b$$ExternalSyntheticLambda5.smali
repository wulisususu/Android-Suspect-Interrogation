.class public final synthetic Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/concurrent/c$c;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/concurrent/b;

.field public final synthetic f$1:Ljava/util/concurrent/Callable;

.field public final synthetic f$2:J

.field public final synthetic f$3:Ljava/util/concurrent/TimeUnit;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/concurrent/b;Ljava/util/concurrent/Callable;JLjava/util/concurrent/TimeUnit;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$1:Ljava/util/concurrent/Callable;

    iput-wide p3, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$2:J

    iput-object p5, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$3:Ljava/util/concurrent/TimeUnit;

    return-void
.end method


# virtual methods
.method public final a(Lcom/aliyun/emas/apm/concurrent/c$b;)Ljava/util/concurrent/ScheduledFuture;
    .locals 6

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$1:Ljava/util/concurrent/Callable;

    iget-wide v2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$2:J

    iget-object v4, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda5;->f$3:Ljava/util/concurrent/TimeUnit;

    move-object v5, p1

    invoke-static/range {v0 .. v5}, Lcom/aliyun/emas/apm/concurrent/b;->$r8$lambda$O-K5cNZElvBbnRjyr2pQqVA-wFQ(Lcom/aliyun/emas/apm/concurrent/b;Ljava/util/concurrent/Callable;JLjava/util/concurrent/TimeUnit;Lcom/aliyun/emas/apm/concurrent/c$b;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p1

    return-object p1
.end method
