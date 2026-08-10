.class public final synthetic Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentFactory;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;

    return-void
.end method


# virtual methods
.method public final create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;

    invoke-static {v0, p1}, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->$r8$lambda$SmRHknomcopF7gm6zIH8fBCgVXE(Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    move-result-object p1

    return-object p1
.end method
