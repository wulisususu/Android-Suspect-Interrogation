from fastapi import APIRouter

router = APIRouter(prefix='/api/device', tags=['device'])


@router.post('/action')
def device_action(payload: dict):
    action_type = payload.get('type', 'unknown')
    return {
        'ok': True,
        'code': 'DEVICE_ACCEPTED',
        'data': {
            'type': action_type,
            'status': 'PENDING_NATIVE_DRIVER'
        }
    }
