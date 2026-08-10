.class public Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;
.super Ljava/lang/Object;
.source "FragmentInterceptorProxy.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;


# static fields
.field public static final INSTANCE:Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;


# instance fields
.field private interceptor:Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->INSTANCE:Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->interceptor:Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;

    return-void
.end method


# virtual methods
.method public getInterceptor()Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->interceptor:Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;

    return-object v0
.end method

.method public needPopFragment(Landroidx/fragment/app/Fragment;)Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->interceptor:Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;

    if-eqz v0, :cond_0

    .line 2
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;->needPopFragment(Landroidx/fragment/app/Fragment;)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public setInterceptor(Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;)Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->interceptor:Lcom/taobao/monitor/impl/processor/fragmentload/IFragmentInterceptor;

    return-object p0
.end method
