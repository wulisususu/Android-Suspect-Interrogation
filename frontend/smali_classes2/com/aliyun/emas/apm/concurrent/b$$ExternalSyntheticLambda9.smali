.class public final synthetic Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/concurrent/Callable;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/concurrent/b;

.field public final synthetic f$1:Ljava/util/concurrent/Callable;

.field public final synthetic f$2:Lcom/aliyun/emas/apm/concurrent/c$b;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/concurrent/b;Ljava/util/concurrent/Callable;Lcom/aliyun/emas/apm/concurrent/c$b;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;->f$1:Ljava/util/concurrent/Callable;

    iput-object p3, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;->f$2:Lcom/aliyun/emas/apm/concurrent/c$b;

    return-void
.end method


# virtual methods
.method public final call()Ljava/lang/Object;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;->f$0:Lcom/aliyun/emas/apm/concurrent/b;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;->f$1:Ljava/util/concurrent/Callable;

    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda9;->f$2:Lcom/aliyun/emas/apm/concurrent/c$b;

    invoke-static {v0, v1, v2}, Lcom/aliyun/emas/apm/concurrent/b;->$r8$lambda$3r__Qk2B8_BDCgtES4vzNuAn3SY(Lcom/aliyun/emas/apm/concurrent/b;Ljava/util/concurrent/Callable;Lcom/aliyun/emas/apm/concurrent/c$b;)Ljava/util/concurrent/Future;

    move-result-object v0

    return-object v0
.end method
