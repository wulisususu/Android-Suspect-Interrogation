.class public final synthetic Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/concurrent/b;

.field public final synthetic f$1:Ljava/lang/Runnable;

.field public final synthetic f$2:Lcom/aliyun/emas/apm/concurrent/c$b;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/concurrent/b;Ljava/lang/Runnable;Lcom/aliyun/emas/apm/concurrent/c$b;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;->f$1:Ljava/lang/Runnable;

    iput-object p3, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;->f$2:Lcom/aliyun/emas/apm/concurrent/c$b;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;->f$1:Ljava/lang/Runnable;

    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda11;->f$2:Lcom/aliyun/emas/apm/concurrent/c$b;

    invoke-static {v0, v1, v2}, Lcom/aliyun/emas/apm/concurrent/b;->$r8$lambda$iAKhi9a2j6tXv27s6S_WT6cAeqY(Lcom/aliyun/emas/apm/concurrent/b;Ljava/lang/Runnable;Lcom/aliyun/emas/apm/concurrent/c$b;)V

    return-void
.end method
