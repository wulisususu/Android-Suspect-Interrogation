.class public final synthetic Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentFactory;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;

    return-void
.end method


# virtual methods
.method public final create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;->a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    move-result-object p1

    return-object p1
.end method
